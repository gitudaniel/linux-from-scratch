#!/bin/sh

echo "Starting compilation of Grep"

tar -xf grep-3.8.tar.xz

cd grep-3.8

# configure
./configure --prefix=/usr    \
            --host=$LFS_TGT

make

make DESTDIR=$LFS install

echo "Finished compilation of Grep"

cd $LFS/sources

rm -rf grep-3.8
