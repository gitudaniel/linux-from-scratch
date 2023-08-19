#!/bin/bash

echo "Starting installation of Libcap"

tar -xf libcap-2.67.tar.xz
cd libcap-2.67

# Prevent static libraries from being installed
sed -i '/install -m.*STA/d' libcap/Makefile

# Compile
make prefix=/usr lib=lib

# Test the results
make test

# Install
make prefix=/usr lib=lib install

echo "Finished installation of Libcap"

cd $LFS/sources
rm -rf libcap-2.67
