#!/bin/sh

echo "Starting compilation of Binutils"

tar -xf binutils-2.40.tar.xz

cd binutils-2.40

# Work around for binutils shipping an outdated copy of libtool in the tarball.
# Produced binaries will be mistakenly linked to libraries from the host distro.
sed '6009s/$add_dir//' -i ltmain.sh

mkdir -v build
cd build

../configure                    \
    --prefix=/usr               \
    --build=$(../config.guess)  \
    --host=$LFS_TGT             \
    --disable-nls               \
    --enable-shared             \
    --enable-gprofng=no         \
    --disable-werror            \
    --enable-64-bit-bfd

make

make DESTDIR=$LFS install

# Remove libtool archive files and unnecessary libraries
rm -v $LFS/usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes}.{a,la}

echo "Finished compilation of Binutils"

cd $LFS/sources

rm -rf binutils-2.40
