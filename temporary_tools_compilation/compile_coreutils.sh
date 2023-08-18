#!/bin/bash

echo "Starting compilation of Coreutils"

tar -xf coreutils-9.1.tar.xz

cd coreutils-9.1

# Apply il8n Coreutils patch
# patch -Np1 -i ../coreutils-9.1-i18n-1.patch

# configure
./configure --prefix=/usr                     \
            --host=$LFS_TGT                   \
            --build=$(build-aux/config.guess) \
            --enable-install-program=hostname \
            --enable-no-install-program=kill,uptime


make

make DESTDIR=$LFS install

# Move programs to their final expected locations
mv -v $LFS/usr/bin/chroot              $LFS/usr/sbin
mkdir -pv $LFS/usr/share/man/man8
mv -v $LFS/usr/share/man/man1/chroot.1 $LFS/usr/share/man/man8/chroot.8
sed -i 's/"1"/"8"/'                    $LFS/usr/share/man/man8/chroot.8


echo "Finishing compilation of Coreutils"

# return to sources directory
cd $LFS/sources

rm -rf coreutils-9.1
