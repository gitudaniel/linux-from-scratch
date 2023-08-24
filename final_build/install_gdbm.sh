#!/bin/bash

echo "Starting installation of GDBM"

tar -xf gdbm-1.23.tar.gz
cd gdbm-1.23

./configure --prefix=/usr    \
            --disable-static \
            --enable-libgdbm-compat

make

make check

make install

echo "Finished installation of GDBM"

cd $LFS/sources
rm -rf gdbm-1.23
