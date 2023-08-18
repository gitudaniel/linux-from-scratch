#!/bin/bash

# run all commands as user lfs in $LFS/sources directory
# https://unix.stackexchange.com/a/11019 source for tarball renaming

echo "Starting compilation of GCC"
tar -xf gcc-12.2.0.tar.xz
cd gcc-12.2.0

# GCC requires the GMP, MPFR and MPC packages.
# Unpack them into the GCC source directory and rename so that the GCC build procedures will automatically use them
tar -xf ../mpfr-4.2.0.tar.xz
mv -v mpfr-4.2.0 mpfr
tar -xf ../gmp-6.2.1.tar.xz
mv -v gmp-6.2.1 gmp
tar -xf ../mpc-1.3.1.tar.gz
mv -v mpc-1.3.1 mpc

# set the default directory for 640bit libraries to "lib"
case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig gcc/config/i386/t-linux64
  ;;
esac

mkdir -v build
cd build

# prepare GCC for compilation
../configure                  \
    --target=$LFS_TGT         \
    --prefix=$LFS/tools       \
    --with-glibc-version=2.37 \
    --with-sysroot=$LFS       \
    --with-newlib             \
    --without-headers         \
    --enable-default-pie      \
    --enable-default-ssp      \
    --disable-nls             \
    --disable-shared          \
    --disable-multilib        \
    --disable-threads         \
    --disable-libatomic       \
    --disable-libgomp         \
    --disable-libquadmath     \
    --disable-libssp          \
    --disable-libvtv          \
    --disable-libstdcxx       \
    --enable-languages=c,c++


make
make install

cd ..
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
  `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/install-tools/include/limits.h

echo "Finishing compilation of GCC"

# go back to sources directory
cd $LFS/sources
rm -rf gcc-12.2.0
