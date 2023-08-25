#!/bin/bash

echo "Starting installation of Check"

tar -xf check-0.15.2.tar.gz
cd check-0.15.2

# Configure
./configure --prefix=/usr --disable-static

# Build the package
make

# Run the test suite
make check

# Install
make docdir=/usr/share/doc/check-0.15.2 install

echo "Finished installation of Check"

cd $LFS/sources
rm -rf check-0.15.2
