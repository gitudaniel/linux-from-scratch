#!/bin/bash

echo "Starting installation of Gawk"

tar -xf gawk-5.2.1.tar.xz
cd gawk-5.2.1

# Ensure some unneeded files are not installed
sed -i 's/extras//' Makefile.in

# Configure
./configure --prefix=/usr

# Compile
make

# Test the results
make check

# Install
# Ensure the previous hard link installed in Section 6.9 is updated here
make LN='ln -f' install

# Install documentation
mkdir -pv                                /usr/share/doc/gawk-5.2.1
cp -v doc/{awkforai.txt,*.{eps,pdf,jpg}} /usr/share/doc/gawk-5.2.1

echo "Finished installation of Gawk"

cd $LFS/sources
rm -rf gawk-5.2.1
