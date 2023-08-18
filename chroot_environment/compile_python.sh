#!/bin/bash

echo "Starting compilation of Python"

tar -xf Python-3.11.2.tar.xz
cd Python-3.11.2

./configure --prefix=/usr   \
            --enable-shared \
            --without-ensurepip

make

make install

echo "Finished compilation of Python"

cd $LFS/sources
rm -rf Python-3.11.2
