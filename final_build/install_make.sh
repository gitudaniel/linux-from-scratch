#!/bin/bash

echo "Starting installation of Make"

tar -xf make-4.4.tar.gz
cd make-4.4

# Fix some issues identified upstream
sed -e '/ifdef SIGPIPE/,+2 d' \
    -e '/undef FATAL_SIG/i FATAL_SIG (SIGPIPE);' \
    -i src/main.c

./configure --prefix=/usr

make

make check

make install

echo "Finished installation of Make"

cd $LFS/sources
rm -rf make-4.4
