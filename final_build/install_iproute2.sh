#!/bin/bash

echo "Starting installation of IPRoute2"

tar -xf iproute2-6.1.0.tar.xz
cd iproute2-6.1.0

# The arpd program included in this package will not be built since
# it depends on the Berkeley DB which is not installed in LFS.
# However, a directory and a man page for arpd will still be installed
sed -i /ARPD/d Makefile
rm -fv man/man8/arpd.8

# Compile
make NETNS_RUN_DIR=/run/netns

# This package does not have a working test suite

# Install
make SBINDIR=/usr/sbin install

# Install documentation
mkdir -pv /usr/share/doc/iproute2-6.1.0
cp -v COPYING README* /usr/share/doc/iproute2-6.1.0

echo "Finished installation of IPRoute2"

cd $LFS/sources
rm -rf iproute2-6.1.0
