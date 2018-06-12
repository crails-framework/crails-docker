#!/bin/sh

git clone https://github.com/Plaristote/crails.git
cd crails
git checkout 3ac893fb8a988dad614d715aefac5808f8af0518

mkdir build
cd build

cmake -DDEVELOPER_MODE=OFF \
      -DUSE_MEMCACHED=OFF \
      -DUSE_MONGODB=OFF \
      -DUSE_ODB=OFF \
      -DUSE_COOKIE_CIPHER=OFF \
      -DUSE_SSL=OFF \
      ..
make && make install
