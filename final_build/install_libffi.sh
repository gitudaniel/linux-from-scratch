#!/bin/bash

echo "Starting installation of Libffi"

tar -xf libffi-3.4.4.tar.gz
cd libffi-3.4.4

./configure --prefix=/usr        \
            --disable-static     \
            --with-gcc-arch=native

make

make check

make install

echo "Finished installation of Libffi"

cd $LFS/sources
rm -rf libffi-3.4.4
