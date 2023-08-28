#!/bin/bash

echo "Starting installation of E2fsprogs"

tar -xf e2fsprogs-1.47.0.tar.gz
cd e2fsprogs-1.47.0

# E2fsprogs documentation recommends that the package be built in a
# subdirectory of the source tree.
mkdir -v build
cd build

../configure --prefix=/usr       \
             --sysconfdir=/etc   \
             --enable-elf-shlibs \
             --disable-libblkid  \
             --disable-libuuid   \
             --disable-uuidd     \
             --disable-fsck

make

# u_direct_io test is known to fail on some systems
make check

make install

# Remove useless static libraries
rm -fv /usr/lib/{libcom_err,libe2p,libext2fs,libss}.a

# This package installs  a gzipped .info file but doesn't update the system-wide
# dir file.
# Unzip this file and then update the system dir file with the below commands.
gunzip -v /usr/share/info/libext2fs.info.gz
install-info --dir-file=/usr/share/info/dir /usr/share/info/libext2fs.info

# Install additional documentation
makeinfo -o      doc/com_err.info ../lib/et/com_err.texinfo
install -v -m644 doc/com_err.info /usr/share/info
install-info --dir-file=/usr/share/info/dir /usr/share/info/com_err.info

echo "Finished installation of E2fsprogs"

cd $LFS/sources
rm -rf e2fsprogs-1.47.0
