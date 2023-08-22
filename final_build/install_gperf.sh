#!/bin bash

echo "Starting installation of Gperf"

tar -xf gperf-3.1.tar.gz
cd gperf-3.1

./configure --prefix=/usr --docdir=/usr/share/doc/gperf-3.1

make

# The tests are known to fail if running multiple simultaneous tests
make -j1 check

make install

echo "Finished installation of Gperf"

cd $LFS/sources
rm -rf gperf-3.1
