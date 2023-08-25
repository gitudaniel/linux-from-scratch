#!/bin/bash

echo "Starting installation of Libpipeline"

tar -xf libpipeline-1.5.7.tar.gz
cd libpipeline-1.5.7

./configure --prefix=/usr

make

make check

make install

echo "Finished installation of Libpipeline"

cd $LFS/sources
rm -rf libpipeline-1.5.7
