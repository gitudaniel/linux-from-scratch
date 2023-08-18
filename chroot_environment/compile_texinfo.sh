#!/bin/bash

echo "Starting compilation of Texinfo"

tar -xf texinfo-7.0.2.tar.xz
cd texinfo-7.0.2

./configure --prefix=/usr

make

make install

echo "Finished compilation of Texinfo"

cd $LFS/sources
rm -rf texinfo-7.0.2
