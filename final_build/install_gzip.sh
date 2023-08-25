#!/bin/bash

echo "Starting installation of Gzip"

tar -xf gzip-1.12.tar.xz
cd gzip-1.12

./configure --prefix=/usr

make

make check

make install

echo "Finished installation of Gzip"

cd $LFS/sources
rm -rf gzip-1.12
