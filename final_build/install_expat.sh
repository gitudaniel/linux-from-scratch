#!/bin/bash

echo "Starting installation of Expat"

tar -xf expat-2.5.0.tar.xz
cd expat-2.5.0

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/expat-2.5.0

make

make check

make install

# Install documentation
install -v -m644 doc/*.{html,css} /usr/share/doc/expat-2.5.0

echo "Finished installation of Expat"

cd $LFS/sources
rm -rf expat-2.5.0
