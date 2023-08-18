#!/bin/bash

echo "Starting installation of File"

tar -xf file-5.44.tar.gz
cd file-5.44

# Prepare File for compilation
./configure --prefix=/usr

# Compile the package
make

# Test the results
make check

# Install the package
make install

echo "Finished installation of File"

cd $LFS/sources
rm -rf file-5.44
