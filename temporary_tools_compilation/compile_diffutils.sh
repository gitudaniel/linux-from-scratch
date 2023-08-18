#!/bin/bash

echo "Starting compilation of Diffutils"

tar -xf diffutils-3.9.tar.xz

cd diffutils-3.9

# configure
./configure --prefix=/usr --host=$LFS_TGT

make

make DESTDIR=$LFS install

echo "Finishing compilation of Binutils"

# return to sources
cd $LFS/sources

rm -rf diffutils-3.9
