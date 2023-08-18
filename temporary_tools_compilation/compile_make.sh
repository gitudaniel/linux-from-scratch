#!/bin/sh

echo "Starting compilation of Make"

tar -xf make-4.4.tar.gz

cd make-4.4

# fix an upstream issue
sed -e '/ifdef SIGPIPE/,+2 d' \
    -e '/undef FATAL_SIG/i FATAL_SIG (SIGPIPE);' \
    -i src/main.c


./configure --prefix=/usr   \
            --without-guile \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)


make

make DESTDIR=$LFS install

echo "Finished compilation of Make"

cd $LFS/sources

rm -rf make-4.4
