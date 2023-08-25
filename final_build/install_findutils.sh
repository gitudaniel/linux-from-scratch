#!/bin/bash

echo "Starting installation of Findutils"

tar -xf findutils-4.9.0.tar.xz
cd findutils-4.9.0

# Configure
case $(uname -m) in
    i?86) TIME_T_32_BIT_OK=yes ./configure --prefix=/usr --localstatedir=/var/lib/locate ;;
    x86_64) ./configure --prefix=/usr --localstatedir=/var/lib/locate ;;
esac

# Compile
make

# Test the results
chown -Rv tester .
su tester -c "PATH=$PATH make check"

# Install
make install

echo "Finished installation of Findutils"

cd $LFS/sources
rm -rf findutils-4.9.0
