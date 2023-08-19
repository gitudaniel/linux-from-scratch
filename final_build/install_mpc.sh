#!/bin/bash

echo "Starting installation of MPC"

tar -xf mpc-1.3.1.tar.gz
cd mpc-1.3.1

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/mpc-1.3.1

make
make html

make check

make install
make install-html

echo "Finished installation of MPC"

cd $LFS/sources
rm -rf mpc-1.3.1
