#!/bin/sh

echo "Starting compilation of Gawk"

tar -xf gawk-5.2.1.tar.xz

cd gawk-5.2.1

# ensure unneeded files are not installed
sed -i 's/extras//' Makefile.in

# configure
./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)


make

make DESTDIR=$LFS install

echo "Finished compilation of Gawk"

cd $LFS/sources

rm -rf gawk-5.2.1
