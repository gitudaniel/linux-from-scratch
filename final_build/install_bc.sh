#!/bin/bash

echo "Starting installation of Bc"

tar -xf bc-6.2.4.tar.xz
cd bc-6.2.4

CC=gcc ./configure --prefix=/usr -G -O3 -r

make

make test

make install

echo "Finished installation of Bc"

cd $LFS/sources
rm -rf bc-6.2.4
