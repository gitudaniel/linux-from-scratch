#!/bin/bash

echo "Starting installation of Binutils"

tar -xf binutils-2.40.tar.xz
cd binutils-2.40

# Verify that PTYs are working properly inside the chroot environment
# Should output `spawn ls`
expect -c "spawn ls"

mkdir -v build
cd build

../configure --prefix=/usr       \
             --sysconfdir=/etc   \
             --enable-gold       \
             --enable-ld=default \
             --enable-plugins    \
             --enable-shared     \
             --disable-werror    \
             --enable-64-bit-bfd \
             --with-system-zlib

# Compile the package
make tooldir=/usr

# Test the results
make -k check

# For a list of failed tests. 12 tests are expected to fail
# in the gold test suite
grep '^FAIL:' $(find -name '*.log') | tee /tmp/binutils_fail.txt

# Install
make tooldir=/usr install

# Remove useless static libraries and an empty man page
rm -fv /usr/lib/lib{bfd,ctf,ctf-nobfd,sframe,opcodes}.a
rm -fv /usr/share/man/man1/{gprofng,gp-*}.1

echo "Finished installation of Binutils"

cd $LFS/sources
rm -rf binutils-2.4.0
