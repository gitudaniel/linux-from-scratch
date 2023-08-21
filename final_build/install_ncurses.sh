#!/bin/bash

echo "Starting installation of Ncurses"

tar -xf ncurses-6.4.tar.gz
cd ncurses-6.4

./configure --prefix=/usr           \
            --mandir=/usr/share/man \
            --with-shared           \
            --without-debug         \
            --without-normal        \
            --with-cxx-shared       \
            --enable-pc-files       \
            --enable-widec          \
            --with-pkg-config-libdir=/usr/lib/pkgconfig

make

# Installation will overwrite libncursesw.so.6.4 in-place.
# It may crash the shell process which is using code and data from the
# library file.
# Install the package with DESTDIR, and replace the library file correctly
# using the install command
make DESTDIR=$PWD/dest install
install -vm755 dest/usr/lib/libncursesw.so.6.4 /usr/lib
rm -v dest/usr/lib/libncursesw.so.6.4
cp -av dest/* /

# Many applications still expect the linker to be able to find non-wide-character
# Ncurses libraries. Trick such applications into linking with wide-character
# libraries by means of symlinks and linker scripts
for lib in ncurses form panel menu ; do
    rm -vf                    /usr/lib/lib${lib}.so
    echo "INPUT(-l${lib}w)" > /usr/lib/lib${lib}.so
    ln -sfv ${lib}w.pc        /usr/lib/pkgconfig/${lib}.pc
done

# Make sure that old applications that look for -lcurses at build time are still buildable
rm -vf                     /usr/lib/libcursesw.so
echo "INPUT(-lncursesw)" > /usr/lib/libcursesw.so
ln -sfv libncurses.so      /usr/lib/libcurses.so

# Install Ncurses documentation
mkdir -pv      /usr/share/doc/ncurses-6.4
cp -v -R doc/* /usr/share/doc/ncurses-6.4

echo "Finished installation of Ncurses"

# The test suite for this package can only be run after installation
echo "Starting Ncurses tests"

cd test/

./configure --prefix=/usr           \
            --mandir=/usr/share/man \
            --with-shared           \
            --without-debug         \
            --without-normal        \
            --with-cxx-shared       \
            --enable-pc-files       \
            --enable-widec          \
            --with-pkg-config-libdir=/usr/lib/pkgconfig

make

echo "Finished Ncurses tests"


cd $LFS/sources
rm -rf ncurses-6.4
