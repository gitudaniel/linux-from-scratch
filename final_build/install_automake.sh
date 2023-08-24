#!/bin/bash

echo "Starting installation of Automake"

tar -xf automake-1.16.5.tar.xz
cd automake-1.16.5

./configure --prefix=/usr --docdir=/usr/share/doc/automake-1.16.5

# Use the -j4 option to speed up tests, even on systems with only 1 processor
# due to internal delays in individual tests.
# The test t/subobj.sh is known to fail.
make -j4 check

make install

echo "Finished installation of Automake"

cd $LFS/sources
rm -rf automake-1.16.5
