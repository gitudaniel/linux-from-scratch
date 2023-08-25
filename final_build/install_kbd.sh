#!/bin/bash

echo "Starting installation of Kbd"

tar -xf kbd-2.5.1.tar.xz
cd kbd-2.5.1

# The behaviour of the backspace and delete keys is not consistent across
# the keymaps in the Kbd package.
# The patch below fixes this issue for i386 keymaps.
# After patching, the backspace generates the character with code 127, and
# the delete key generates a well-known escape sequence.
patch -Np1 -i ../kbd-2.5.1-backspace-1.patch

# Remove the redundant resizecons program together with its manpage.
# For normal use setfont sizes the console appropriately.
sed -i '/RESIZECONS_PROGS=/s/yes/no/' configure
sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in

# Configure
./configure --prefix=/usr --disable-vlock

make

make check

make install

# Install documentation
mkdir -pv /usr/share/doc/kbd-2.5.1
cp -R -v docs/doc/* /usr/share/doc/kbd-2.5.1

echo "Finished installation of Kbd"

cd $LFS/sources
rm -rf kbd-2.5.1
