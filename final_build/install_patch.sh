#!/bin/bash

echo "Starting installation of Patch"

tar -xf patch-2.7.6.tar.xz
cd patch-2.7.6

./configure --prefix=/usr

make

make check

make install

echo "Finished installation of Patch"

cd $LFS/sources
rm -rf patch-2.7.6
