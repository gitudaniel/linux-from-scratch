#!/bin/bash

echo "Starting compilation of File"

tar -xf file-5.44.tar.gz

cd file-5.44

# make a temporary copy of the file command
mkdir build
pushd build
  ../configure --disable-bzlib      \
               --disable-libseccomp \
               --disable-xzlib      \
               --disable-zlib
  make
popd

# configure
./configure --prefix=/usr --host=$LFS_TGT --build=$(./config.guess)

# compile the package
make FILE_COMPILE=$(pwd)/build/src/file

# install
make DESTDIR=$LFS install

# Remove the libtool archive because it is harmful for cross compilation
rm -v $LFS/usr/lib/libmagic.la

echo "Finishing compilation of File"

cd $LFS/sources

rm -rf file-5.44
