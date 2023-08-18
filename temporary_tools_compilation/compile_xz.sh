#!/bin/sh

echo "Starting compilation of Xz"

tar -xf xz-5.4.1.tar.xz

cd xz-5.4.1

./configure --prefix=/usr                     \
            --host=$LFS_TGT                   \
            --build=$(build-aux/config.guess) \
            --disable-static                  \
            --docdir=/usr/share/doc/xz-5.4.1

make

make DESTDIR=$LFS install

# remove the libtool archive file because it is harmful for cross compilation
rm -v $LFS/usr/lib/liblzma.la


echo "Finished compilation of Xz"

cd $LFS/sources

rm -rf xz-5.4.1
