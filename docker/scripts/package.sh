#!/bin/bash -ex

app_dir="/opt/webapp"
backend_dir="$app_dir/crailsapp"
docker_dir="$app_dir/docker"
output_dir="$app_dir/runtime"
build_dir="$docker_dir/build"
build_config="$app_dir/configuration"
public_source_dir="$backend_dir/public"

lib_dir="$output_dir/lib"
bin_dir="$output_dir/bin"
public_dir="$output_dir/public"

rm -Rf "$output_dir"/*
mkdir -p "$lib_dir" "$bin_dir" "$public_dir"

##
## Build the application
##
# Configure cmake
export CC=/usr/bin/cc
export CCX=/usr/bin/c++
mkdir -p "$build_dir" && cd "$build_dir"
cmake_options="-DDEVELOPER_MODE=OFF"

if test -s "$build_config" ; then
  cmake_module_options=`cat $build_config`
  cmake_options="$cmake_options $cmake_module_options"
fi

cmake "$backend_dir" $cmake_options

# Configure crails-guard
export CRAILS_BUILD_PATH="$build_dir"
export CRAILS_PUBLIC_PATH="$public_dir"
export CRAILS_RUBY_BUNDLE_PATH="$CRAILS_BUILD_PATH"

# Build server
cd "$backend_dir"
crails compile before_compile \
               compile \
               tests

retval=$?
if [[ $retval != 0 ]] ; then
  echo "Server build failed ($retval); aborting package.sh"
  exit -1
else
  echo "Server built successfully"
fi

##
## Package application
##
# Export dependencies
dependencies=`ldd "$build_dir/server" | grep /usr/local | cut -d' ' -f3`
for dependency in $dependencies ; do
  cp "$dependency" "$lib_dir"
done

# Export server and task binaries
cp "$build_dir/libcrails-app.so" "$lib_dir"
cp "$build_dir/server" "$bin_dir"
mkdir -p "$build_dir/tasks"
for task in `ls $build_dir/tasks` ; do
  mkdir -p "$bin_dir/tasks/$task"
  cp "$build_dir/tasks/$task/task" "$bin_dir/tasks/$task/"
done

# Export assets
cp -R "$public_source_dir" "$output_dir"

# Export scripts
for script in Procfile launch.sh launch-crailsapp.sh launch-sidekic.sh; do
  cp "$docker_dir/scripts/$script" "$output_dir/"
done

# Set revision tag on index.html
sed -e 's:${revision_tag}:'`git rev-list HEAD --max-count=1`':g' "$public_source_dir/index.html" > "$public_dir/index.html"

# Set permissions
chmod -R ugo+rw "$output_dir"
chmod -R ugo+x "$bin_dir"

echo "[crails-docker] All done"
