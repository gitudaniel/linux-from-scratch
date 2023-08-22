#!/bin/bash

echo "Starting installation of Less"

tar -xf less-608.tar.gz
cd less-608

./configure --prefix=/usr --sysconfdir=/etc

make

# Package does not come with a test suite

make install

echo "Finished installation of Less"

cd $LFS/sources
rm -rf less-608
