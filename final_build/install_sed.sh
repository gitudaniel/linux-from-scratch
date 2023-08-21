#!/bin/bash

echo "Starting installation of Sed"

tar -xf sed-4.9.tar.xz
cd sed-4.9

./configure --prefix=/usr

# Compile the package and generate HTML documentation
make
make html

# Test the results
chown -Rv tester .
su tester -c "PATH=$PATH make check"

# Install the package and its documentation
make install
install -d -m755           /usr/share/doc/sed-4.9
install -m644 doc/sed.html /usr/share/doc/sed-4.9

echo "Finished installation of Sed"

cd $LFS/sources
rm -rf sed-4.9
