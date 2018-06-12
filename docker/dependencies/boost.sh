#!/bin/sh

boost_version_major="1"
boost_version_minor="66"
boost_version_patch="0"
boost_directory="boost_${boost_version_major}_${boost_version_minor}_${boost_version_patch}"

wget -O download https://dl.bintray.com/boostorg/release/${boost_version_major}.${boost_version_minor}.${boost_version_patch}/source/boost_${boost_version_major}_${boost_version_minor}_${boost_version_patch}.tar.gz
tar -zxvf download && rm download

cd "${boost_directory}"

./bootstrap.sh \
  --with-toolset=gcc \
  --without-libraries=python

./b2 \
  toolset="gcc" \
  threading="multi" \
  link="shared" \
  cxxflags="-std=c++11" \
  release install
