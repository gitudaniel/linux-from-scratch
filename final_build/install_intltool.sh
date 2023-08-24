#!/bin/bash

echo "Starting installation of Intltool"

tar -xf intltool-0.51.0.tar.gz
cd intltool-0.51.0

# Fix a warning caused by perl-5.22 and later
sed -i 's:\\\${:\\\$\\{:' intltool-update.in

./configure --prefix=/usr

make

make check

make install
install -v -Dm644 doc/I18N-HOWTO /usr/share/doc/intltool-0.51.0/I18N-HOWTO

echo "Finished installation of Intltool"

cd $LFS/sources
rm -rf intltool-0.51.0
