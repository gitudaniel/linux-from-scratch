#!/bin/bash

echo "Starting installation of Inetutils"

tar -xf inetutils-2.4.tar.xz
cd inetutils-2.4

./configure --prefix=/usr        \
            --bindir=/usr/bin    \
            --localstatedir=/var \
            --disable-logger     \
            --disable-whois      \
            --disable-rcp        \
            --disable-rexec      \
            --disable-rlogin     \
            --disable-rsh        \
            --disable-servers

make

make check

make install

# Move a program to the proper location
mv -v /usr/{,s}bin/ifconfig

echo "Finished installation of Inetutils"

cd $LFS/sources
rm -rf inetutils-2.4
