#!/bin/bash

echo "Starting installation of Psmisc"

tar -xf psmisc-23.6.tar.xz
cd psmisc-23.6

./configure --prefix=/usr

make

# This package does not come with a test suite

make install

echo "Finished installation of Psmisc"

cd $LFS/sources
rm -rf psmisc-23.6
