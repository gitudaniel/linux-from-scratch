#!/bin/bash

echo "Starting installation of ACL"

tar -xf acl-2.3.1.tar.xz
cd acl-2.3.1

./configure --prefix=/usr        \
            --disable-static     \
            --docdir=/usr/share/doc/acl-2.3.1

# Compile
make

# Acl tests must be run on a filesystem that supports access controls, but not
# until the Coreutils package has been build using the Acl libraries.
# Run the command below after the Coreutils package has been built
## make check

# Install
make install

echo "Finished installation of ACL"

cd $LFS/sources
rm -rf acl-2.3.1
