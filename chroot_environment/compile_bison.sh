#!/bin/bash

echo "Starting compilation of Bison"

tar -xf bison-3.8.2.tar.xz
cd bison-3.8.2

./configure --prefix=/usr \
            --docdir=/usr/share/doc/bison-3.8.2

make

make install

echo "Finished compilation of Bison"

cd $LFS/sources
rm -rf bison-3.8.2
