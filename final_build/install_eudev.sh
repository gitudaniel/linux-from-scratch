#!/bin/bash

echo "Starting installation of Eudev"

tar -xf eudev-3.2.11.tar.gz
cd eudev-3.2.11

# Fix the location of udev files in the .pc file
sed -i '/udevdir/a udev_dir=${udevdir}' src/udev/udev.pc.in

./configure --prefix=/usr      \
            --bindir=/usr/sbin \
            --sysconfdir=/etc  \
            --enable-manpages  \
            --disable-static

make

# Create directories needed for tests and installation
mkdir -pv /usr/lib/udev/rules.d
mkdir -pv /etc/udev/rules.d

make check

make install

# Install some custom rules and support files useful in an LFS environment
tar -xvf ../udev-lfs-20171102.tar.xz
make -f udev-lfs-20171102/Makefile.lfs install

# Eudev needs information about hardware devices to be compiled into a binary database
# /etc/udev/hwdb.bin.
# This information is maintained in the /etc/udev/hwdb.d and /usr/lib/udev/hwdb.b directories.
# The command below creates the initial database.
udevadm hwdb --update

echo "Finished installation of Eudev"

cd $LFS/sources
rm -rf eudev-3.2.11
