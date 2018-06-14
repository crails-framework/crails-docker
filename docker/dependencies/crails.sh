#!/bin/sh

git clone https://github.com/Plaristote/crails.git
cd crails
git checkout 597fd774b434bee50db4bbf7945b823535f486db

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
