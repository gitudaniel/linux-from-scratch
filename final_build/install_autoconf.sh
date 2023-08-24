#!/bin/bash

echo "Starting installation of Autoconf"

tar -xf autoconf-2.71.tar.xz
cd autoconf-2.71

# Fix several problems with the tests caused by bash-5.2 and later
sed -e 's/SECONDS|/&SHLVL|/'                \
    -e '/BASH_ARGV=/a\         /^SHLVL=/ d' \
    -i.orig tests/local.at

./configure --prefix=/usr

make

# Test time for autoconf can be reduced significantly on a system with multiple cores
# My system has 2 cores
make check TESTSUITEFLAGS=-j2

make install

echo "Finished installation of Autoconf"

cd $LFS/sources
rm -rf autoconf-2.71
