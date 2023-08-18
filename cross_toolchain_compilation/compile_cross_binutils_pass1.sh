#!/bin/bash

# run commands as user lfs in the /mnt/lfs/sources directory

echo "Starting compilation of binutils"
tar -xf binutils-2.40.tar.xz

cd binutils-2.40

mkdir -v build
cd build

../configure --prefix=$LFS/tools \
             --with-sysroot=$LFS \
             --target=$LFS_TGT   \
             --disable-nls       \
             --enable-gprofng=no \
             --disable-werror

# virtual machine has 2 cpus use both to make and install application
make 

make install

echo "Finishing compilation of binutils"

# go back to sources directory
cd $LFS/sources
rm -rf binutils-2.40

