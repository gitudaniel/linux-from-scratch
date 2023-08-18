#!/bin/sh

echo "Starting compilation of GCC"

tar -xf gcc-12.2.0.tar.xz

cd gcc-12.2.0

# Unpack tarballs of required GMP, MPFR and MPC packages and move them into required directories
tar -xf ../mpfr-4.2.0.tar.xz
mv -v mpfr-4.2.0 mpfr
tar -xf ../gmp-6.2.1.tar.xz
mv -v gmp-6.2.1 gmp
tar -xf ../mpc-1.3.1.tar.gz
mv -v mpc-1.3.1 mpc

# Change default directory name for 64-bit libraries to "lib"
case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64
  ;;
esac

# Override the building rule of libgcc and libstdc++ headers
# to allow building these libraries with POSIX threads support
sed '/thread_header =/s/@.*@/gthr-posix.h/' \
    -i libgcc/Makefile.in libstdc++-v3/include/Makefile.in

mkdir -v build
cd build

../configure                                   \
    --build=$(../config.guess)                 \
    --host=$LFS_TGT                            \
    --target=$LFS_TGT                          \
    LDFLAGS_FOR_TARGET=-L$PWD/$LFS_TGT/libgcc  \
    --prefix=/usr                              \
    --with-build-sysroot=$LFS                  \
    --enable-default-pie                       \
    --enable-default-ssp                       \
    --disable-nls                              \
    --disable-multilib                         \
    --disable-libatomic                        \
    --disable-libgomp                          \
    --disable-libquadmath                      \
    --disable-libssp                           \
    --disable-libvtv                           \
    --enable-languages=c,c++

make

make DESTDIR=$LFS install

# Create a utility symlink. Many programs and scripts run cc instead of gcc.
# This keeps programs generic and therefore usable on all kinds of UNIX systems
# where the GNU C compiler is not always installed.
ln -sv gcc $LFS/usr/bin/cc

echo "Finished compilation of GCC"

cd $LFS/sources

rm -rf {gcc-12.2.0, mpfr, gmp, mpc}
