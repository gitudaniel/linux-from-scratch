#!/bin/bash

echo "Starting installation of Diffutils"

tar -xf diffutils-3.9.tar.xz
cd diffutils-3.9

# Configure
./configure --prefix=/usr

# Compile
make

# Test the results
make check

# Install
make install

echo "Finished installation of Diffutils"

cd $LFS/sources
rm -rf diffutils-3.9
