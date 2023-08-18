#!/bin/bash

echo "Starting installation of Flex"

tar -xf flex-2.6.4.tar.gz
cd flex-2.6.4

./configure --prefix=/usr \
            --docdir=/usr/share/doc/flex-2.6.4 \
            --disable-static

make

make check

make install

# A few programs do not know about flex yet and try to run its predecessor lex.
# Create a symbolic link named lex that runs flex in lex emulation mode
# to support such programs
ln -sv flex /usr/bin/lex

echo "Finished installation of flex"

cd $LFS/sources
rm -rf flex-2.6.4
