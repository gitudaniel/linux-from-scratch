#!/bin/sh

echo "Starting compilation of Patch"

tar -xf patch-2.7.6.tar.xz

cd patch-2.7.6

./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)


make

make DESTDIR=$LFS install

echo "Finished compilation of Patch"

cd $LFS/sources

rm -rf patch-2.7.6
