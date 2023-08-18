#!/bin/sh

echo "Starting compilation of Sed"

tar -xf sed-4.9.tar.xz

cd sed-4.9

./configure --prefix=/usr    \
            --host=$LFS_TGT

make

make DESTDIR=$LFS install

echo "Finished compilation of Sed"

cd $LFS/sources

rm -rf sed-4.9
