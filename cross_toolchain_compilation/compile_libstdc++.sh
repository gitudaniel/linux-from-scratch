#!/bin/bash

echo "Starting compilation of Libstdc++"
tar -xf gcc-12.2.0.tar.xz
cd gcc-12.2.0

mkdir -v build
cd build

../libstdc++-v3/configure            \
    --host=$LFS_TGT                  \
    --build=$(../config.guess)       \
    --prefix=/usr                    \
    --disable-multilib               \
    --disable-nls                    \
    --disable-libstdcxx-pch          \
    --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/12.2.0


make

make DESTDIR=$LFS install

# Remove the libtool archive files because they are harmful for cross-compilation
rm -v $LFS/usr/lib/lib{stdc++,stdc++fs,supc++}.la

echo "Finishing compilation of Libstdc++"

# go back to sources directory
cd $LFS/sources

rm -rf gcc-12.2.0
