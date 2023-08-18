#!/bin/bash

echo "Starting installation of Bzip2"

tar -xf bzip2-1.0.8.tar.gz
cd bzip2-1.0.8

# Apply a patch that will install the documentation for this package
patch -Np1 -i ../bzip2-1.0.8-install_docs-1.patch

# The command below ensures installation of symbolic links are relative
sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile

# Ensure the man pages are installed into the correct location
sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" Makefile

# Prepare bzip2 for compilation
make -f Makefile-libbz2_so
make clean

# Compile and test the package
make

# Install the programs
make PREFIX=/usr install

# Install the shared library
cp -av libbz2.so.* /usr/lib
ln -sv libbz2.so.1.0.8 /usr/lib/libbz2.so

# Install the shared bzip2 binary into the /usr/bin directory and replace
# two copies of bzip2 with symlinks
cp -v bzip2-shared /usr/bin/bzip2
for i in /usr/bin/{bzcat,bunzip2}; do
  ln -sfv bzip2 $i
done

# Remove useless static library
rm -fv /usr/lib/libbz2.a

echo "Finished installation of bzip2"

cd $LFS/sources
rm -rf bzip2-1.0.8
