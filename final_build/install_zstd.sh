#!/bin/bash

echo "Starting installation of Zstd"

tar -xf zstd-1.5.4.tar.gz
cd zstd-1.5.4

# Compile the package
make prefix=/usr

# Test the results
make check

# Install the package
make prefix=/usr install

# Remove the static library
rm -v /usr/lib/libzstd.a

echo "Finished installation of zstd"

cd $LFS/sources
rm -rf zstd-1.5.4
