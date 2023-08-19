#!/bin/bash

echo "Starting installation of Attr"

tar -xf attr-2.5.1.tar.gz
cd attr-2.5.1

./configure --prefix=/usr     \
            --disable-static  \
            --sysconfdir=/etc \
            --docdir=/usr/share/doc/attr-2.5.1

make

make check

make install

echo "Finished installation of Attr"

cd $LFS/sources
rm -rf attr-2.5.1
