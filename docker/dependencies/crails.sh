#!/bin/sh

git clone https://github.com/Plaristote/crails.git
cd crails
git checkout 3ac893fb8a988dad614d715aefac5808f8af0518

mkdir build
cd build

sed -e '47d' ../CMakeLists.txt > CMakeLists.txt
mv CMakeLists.txt ..

cmake -DDEVELOPER_MODE=OFF \
      -DUSE_MEMCACHED=OFF \
      -DUSE_MONGODB=OFF \
      -DUSE_COOKIE_CIPHER=OFF \
      ..
make && make install
