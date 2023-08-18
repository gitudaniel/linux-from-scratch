#!/bin/sh

echo "Starting compilation of M4"

tar -xf m4-1.4.19.tar.xz

cd m4-1.4.19

./configure --prefix=/usr    \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)

make

make DESTDIR=$LFS install

echo "Finishing compilation of M4"

# go back to sources directory
cd $LFS/sources

rm -rf m4-1.4.19
