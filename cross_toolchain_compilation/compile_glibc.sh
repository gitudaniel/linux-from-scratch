#!/bin/bash

# run all commands as user lfs in the $LFS/sources directory

echo "Starting compilation of Glibc"
tar -xf glibc-2.37.tar.xz

cd glibc-2.37

case $(uname -m) in
    i?86)    ln -sfv ld-linux.so.2 $LFS/lib/ld-lsb.so.3
    ;;
    x86_64)  ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
             ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3
    ;;
esac

# Apply patch to make Glibc programs strore their runtime data in the FHS-compliant locations
patch -Np1 -i ../glibc-2.37-fhs-1.patch

mkdir -v build
cd build

# ensure ldconfig and sln utilities are installed into /usr/sbin
echo "rootsbindir=/usr/sbin" > configparms


../configure                           \
    --prefix=/usr                      \
    --host=$LFS_TGT                    \
    --build=$(../scripts/config.guess) \
    --enable-kernel=3.2                \
    --with-headers=$LFS/usr/include    \
    libc_cv_slibdir=/usr/lib


make

make DESTDIR=$LFS install

# Fix a hard coded path to the executable loader in the ldd script
sed '/RTLDLIST=/s@/usr@@g' -i $LFS/usr/bin/ldd


# Sanity checks **IMPERATIVE**
echo 'int main(){}' | $LFS_TGT-gcc -xc -
readelf -l a.out | grep ld-linux


# Clean up the test file
rm -v a.out


# finalize th installation of the limits.h header
$LFS/tools/libexec/gcc/$LFS_TGT/12.2.0/install-tools/mkheaders

echo "Finishing compilation of Glibc"

# go back to sources directory
cd $LFS/sources
rm -rf glibc-2.37
