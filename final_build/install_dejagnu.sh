#!/bin/bash

echo "Started installation of DejaGNU"

tar -xf dejagnu-1.6.3.tar.gz
cd dejagnu-1.6.3

# Build DejaGNU in a dedicated build directory
mkdir -v build
cd build

# Prepare for compilation
../configure --prefix=/usr
makeinfo --html --no-split -o doc/dejagnu.html ../doc/dejagnu.texi
makeinfo --plaintext       -o doc/dejagnu.txt  ../doc/dejagnu.texi

# Build and install the package
make install
install -v -dm755  /usr/share/doc/dejagnu-1.6.3
install -v -m644   doc/dejagnu.{html,txt} /usr/share/doc/dejagnu-1.6.3

# Test the results
make check

echo "Finished installation of DejaGNU"

cd $LFS/sources
rm -rf dejagnu-1.6.3
