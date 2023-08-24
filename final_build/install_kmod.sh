#!/bin/bash

echo "Starting installation of Kmod"

tar -xf kmod-30.tar.xz
cd kmod-30

./configure --prefix=/usr     \
            --sysconfdir=/etc \
            --with-openssl    \
            --with-xz         \
            --with-zstd       \
            --with-zlib

make

# The test suite of this package requires raw kernel headers (not the
# "sanitized" kernel headers installed earlier) which are beyond the
# scope of LFS

# Install the package and create symlinks for compatibility with Module-Init-Tools
# (the package that previously handled Linux kernel modules)
make install

for target in depmod insmod modinfo modprobe rmmod; do
  ln -sfv ../bin/kmod /usr/sbin/$target
done

ln -sfv kmod /usr/bin/lsmod

echo "Finished installation of Kmod"

cd $LFS/sources
rm -rf kmod-30
