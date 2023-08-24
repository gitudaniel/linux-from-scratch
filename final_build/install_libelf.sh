#!/bin/bash

echo "Starting installation of Libelf"

tar -xf elfutils-0.188.tar.bz2
cd elfutils-0.188

./configure --prefix=/usr            \
            --disable-debuginfod     \
            --enable-libdebuginfod=dummy

make

# Test named run-native-test.sh is known to fail
make check

make -C libelf install
install -vm644 config/libelf.pc /usr/lib/pkgconfig
rm /usr/lib/libelf.a

echo "Finished installation of Libelf"

cd $LFS/sources
rm -rf elfutils-0.188
