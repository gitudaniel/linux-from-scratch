#!/bin/bash

echo "Starting installation of Libtool"

tar -xf libtool-2.4.7.tar.xz
cd libtool-2.4.7

./configure --prefix=/usr

make

# Test time for the package can be reduced significantly by appending TESTSUITEFLAGS=-j<N>
# on a system with multiple cores.
# My virtual machine has 2 cores
# Five tests are known to fail in the LFS build environment due to a circular dependency.
# These tests pass if rechecked after automake has been installed.
# Additionally, with grep-3.8, 2 tests trigger a warning for non-POSIX regular expressions and fail
make -k check TESTSUITEFLAGS=-j2

make install

# Remove useless static library
rm -fv /usr/lib/libltdl.a

echo "Finished installation of Libtool"

cd $LFS/sources
rm -rf libtool-2.4.7
