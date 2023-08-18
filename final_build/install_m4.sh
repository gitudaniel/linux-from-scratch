#!/bin/bash

echo "Starting installation of M4"

tar -xf m4-1.4.19.tar.xz
cd m4-1.4.19

# Prepare M4 for compilation
./configure --prefix=/usr

# Compile the package
make

# Test results
make check

# Install the package
make install

echo "Finished installation of M4"

cd $LFS/sources
rm -rf m4-1.4.19
