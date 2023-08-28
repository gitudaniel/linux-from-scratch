#!/bin/bash

echo "Starting installation of Man-DB"

tar -xf man-db-2.11.2.tar.xz
cd man-db-2.11.2

./configure --prefix=/usr                         \
            --docdir=/usr/share/doc/man-db-2.11.2 \
            --sysconfdir=/etc                     \
            --disable-setuid                      \
            --enable-cache-owner=bin              \
            --with-browser=/usr/bin/lynx          \
            --with-vgrind=/usr/bin/vgrind         \
            --with-grap=/usr/bin/grap             \
            --with-systemdtmpfilesdir=            \
            --with-systemdsystemunitdir=

make

make check

make install

echo "Finished installation of Man-DB"

cd $LFS/sources
rm -rf man-db-2.11.2
