#!/bin/bash

echo "Starting compilation of Gettext"

tar -xf gettext-0.21.1.tar.xz
cd gettext-0.21.1

./configure --disable-shared

make

# Install msgfmt, msgmerge and xgettext programs
cp -v gettext-tools/src/{msgfmt,msgmerge,xgettext} /usr/bin

echo "Finished compilation of Gettext"

cd $LFS/sources

rm -rf gettext 0.21.1
