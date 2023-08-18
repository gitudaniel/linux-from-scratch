#!/bin/bash

echo "Starting compilation of util-linux"

tar -xf util-linux-2.38.1.tar.xz
cd util-linux-2.38.1

# Filesystem Hierarchy Standard (FHS) recommends using the /var/lib/hwclock directory
# instead of the usual /etc directory as the location for the adjtime file
mkdir -pv /var/lib/hwclock

./configure ADJTIME_PATH=/var/lib/hwclock/adjtime    \
            --libdir=/usr/lib    \
            --docdir=/usr/share/doc/util-linux-2.38.1 \
            --disable-chfn-chsh  \
            --disable-login      \
            --disable-nologin    \
            --disable-su         \
            --disable-setpriv    \
            --disable-runuser    \
            --disable-pylibmount \
            --disable-static     \
            --without-python     \
            runstatedir=/run

make

make install

echo "Finished compilation of util-linux"

cd $LFS/sources
rm -rf util-linux-2.38.1
