#!/bin/sh

echo "Starting compilation of Ncurses"

tar -xf ncurses-6.4.tar.gz

cd ncurses-6.4

sed -i s/mawk// configure

mkdir build
pushd build
  ../configure
  make -C include
  make -C progs tic
popd

# configuration
./configure --prefix=/usr                   \
            --host=$LFS_TGT                 \
            --build=$(./config.guess)       \
            --mandir=/usr/share/man         \
            --with-manpage-format=normal    \
            --with-shared                   \
            --without-normal                \
            --with-cxx-shared               \
            --without-debug                 \
            --without-ada                   \
            --disable-stripping             \
            --enable-widec


make

make DESTDIR=$LFS TIC_PATH=$(pwd)/build/progs/tic install
echo "INPUT(-lncursesw)" > $LFS/usr/lib/libncurses.so

echo "Finishing compilation of Ncurses"

# go back to sources directory
cd $LFS/sources

rm -rf ncurses-6.4
