#!/bin/bash

echo "Starting installation of Pkg-config"

tar -xf pkg-config-0.29.2.tar.gz
cd pkg-config-0.29.2

./configure --prefix=/usr        \
            --with-internal-glib \
            --disable-host-tool  \
            --docdir=/usr/share/doc/pkg-config-0.29.2

make

make check

make install

echo "Finished installation of Pkg-config"

cd $LFS/sources
rm -rf pkg-config-0.29.2
