#!/bin/sh

git clone https://github.com/cpp-netlib/cpp-netlib.git

mkdir cpp-netlib/build
cd cpp-netlib/build

git checkout 0.13-release

git submodule init
git submodule update

cmake -DCMAKE_CXX_FLAGS=-std=c++11 \
  -DCPP-NETLIB_BUILD_TESTS=OFF \
  -DCPP-NETLIB_BUILD_EXAMPLES=OFF \
  -DCPP-NETLIB_BUILD_SHARED_LIBS=ON \
  -DUri_BUILD_TESTS=OFF \
  -DUri_WARNINGS_AS_ERRORS=OFF \
  ..

make
make install
