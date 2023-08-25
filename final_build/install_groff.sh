#!/bin/bash

echo "Starting installation of Groff"

tar -xf groff-1.22.4.tar.gz
cd groff-1.22.4

PAGE=A4 ./configure --prefix=/usr

make

# This package does not come with a test suite

make install

echo "Finished installation of Groff"

cd $LFS/sources
rm -rf groff-1.22.4
