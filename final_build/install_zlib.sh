#!/bin/bash

echo "Starting installation of zlib"

tar -xf zlib-1.2.13.tar.xz
cd zlib-1.2.13

./configure --prefix=/usr

make

make check

make install

# Remove a useless static library
rm -fv /usr/lib/libz.a

echo "Finished installation of zlib"

cd $LFS/sources
rm -rf zlib-1.2.13
