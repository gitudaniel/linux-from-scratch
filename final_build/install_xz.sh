#!/bin/bash

echo "Starting installation of Xz"

tar -xf xz-5.4.1.tar.xz
cd xz-5.4.1

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/xz-5.4.1

make

make check

make install

echo "Finished installation of Xz"

cd $LFS/sources
rm -rf xz-5.4.1
