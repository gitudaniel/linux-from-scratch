#!/bin/bash

echo "Starting compilation of Findutils"

tar -xf findutils-4.9.0.tar.xz

cd findutils-4.9.0

# configure
./configure --prefix=/usr                   \
            --localstatedir=/var/lib/locate \
            --host=$LFS_TGT                 \
            --build=$(build-aux/config.guess)


make

make DESTDIR=$LFS install

echo "Finished compilation of Findutils"
cd $LFS/sources

rm -rf findutils-4.9.0
