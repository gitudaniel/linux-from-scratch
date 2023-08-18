#!/bin/bash

echo "Starting compilation of Gzip"

tar -xf gzip-1.12.tar.xz

cd gzip-1.12

./configure --prefix=/usr --host=$LFS_TGT

make

make DESTDIR=$LFS install

echo "Finished compilation of Gzip"

cd $LFS/sources

rm -rf gzip-1.12
