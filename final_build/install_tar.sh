#!/bin/bash

echo "Starting installation of Tar"

tar -xf tar-1.34.tar.xz
cd tar-1.34

FORCE_UNSAFE_CONFIGURE=1 \
./configure --prefix=/usr

make

# capabilities: binary store/restore test is known to fail if it is run because
# LFS lacks selinux, but will be skipped if the host kernel does not support
# extended attributes on the filesystem used for building LFS.
make check

make install
make -C doc install-html docdir=/usr/share/doc/tar-1.34

echo "Finished installation of Tar"

cd $LFS/sources
rm -rf tar-1.34
