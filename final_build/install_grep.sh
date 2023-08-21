#!/bin/bash

echo "Starting installation of Grep"

tar -xf grep-3.8.tar.xz
cd grep-3.8

# Remove a warning about using egrep and fgrep that makes tests on some packages fail
sed -i "s/echo/#echo/" src/egrep.sh

./configure --prefix=/usr

make

make check

make install

echo "Finished installation of Grep"

cd $LFS/sources
rm -rf grep-3.8
