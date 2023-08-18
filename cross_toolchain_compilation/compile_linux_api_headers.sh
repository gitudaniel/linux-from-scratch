#!/bin/bash

echo "Starting compilation of Linux API Headers"
tar -xf linux-6.1.11.tar.xz
cd linux-6.1.11

make mrproper

make headers
find usr/include -type f ! -name '*.h' -delete
cp -rv usr/include $LFS/usr

echo "Finishing compilation of Linux API Headers"

# go back to sources directory
cd $LFS/sources
rm -rf linux-6.1.11

