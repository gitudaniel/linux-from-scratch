#!/bin/bash

echo "Starting installation of Procps-ng"

tar -xf procps-ng-4.0.2.tar.xz
cd procps-ng-4.0.2

./configure --prefix=/usr                           \
            --docdir=/usr/share/doc/procps-ng-4.0.2 \
            --disable-static                        \
            --disable-kill

make

# One test named `free with commit` may fail if some applications with a custom memory
# allocator (e.g. JVM and Web Browsers) are running on the host distro.
make check

make install

echo "Finished installation of Procps-ng"

cd $LFS/sources
rm -rf procps-ng-4.0.2
