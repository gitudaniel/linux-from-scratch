#!/bin/bash

echo "Starting installation of Grub"

tar -xf grub-2.06.tar.xz
cd grub-2.06

# Unset any environment variable which may affect the build
unset {C,CPP,CXX,LD}FLAGS

# Fix an issue causing grub-install to fail when the /boot partition
# is created by e2fsprogs-1.47.0 or later
patch -Np1 -i ../grub-2.06-upstream_fixes-1.patch

# Configure
./configure --prefix=/usr      \
            --sysconfdir=/etc  \
            --disable-efiemu   \
            --disable-werror

# Compile
make

# The test suite for this package is not recommended.
# Most of the tests depend on packages that are not available in the
# limited LFS environment

# Install
make install
mv -v /etc/bash_completion.d/grub /usr/share/bash-completion/completions

echo "Finished installation of Grub"

cd $LFS/sources
rm -rf grub-2.06
