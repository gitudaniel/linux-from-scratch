#!/bin/bash

echo "Starting installation of Gettext"

tar -xf gettext-0.21.1.tar.xz
cd gettext-0.21.1

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/gettext-0.21.1

make

make check

make install
chmod -v 0755 /usr/lib/preloadable_libintl.so

echo "Finished installation of Gettext"

cd $LFS/sources
rm -rf gettext-0.21.1
