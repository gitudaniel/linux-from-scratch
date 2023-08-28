#!/bin/bash

echo "Starting installation of Sysvinit"

tar -xf sysvinit-3.06.tar.xz
cd sysvinit-3.06

# Apply a patch that removes several programs installed by other packages,
# clarifies a message, and fixes a compiler warning.
patch -Np1 -i ../sysvinit-3.06-consolidated-1.patch

make

# This package does not come with a test suite

make install

echo "Finished installation of Sysvinit"

cd $LFS/sources
rm -rf sysvinit-3.06
