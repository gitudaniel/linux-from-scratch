#!/bin/sh

echo "Starting compilation of Bash"

tar -xf bash-5.2.15.tar.gz

cd bash-5.2.15

# configure
./configure --prefix=/usr                      \
            --build=$(sh support/config.guess) \
            --host=$LFS_TGT                    \
            --without-bash-malloc

make

make DESTDIR=$LFS install

# Link to programs that use sh for a shell:
ln -sv bash $LFS/bin/sh

echo "Finished compilation of Bash"

# go back to sources directory
cd $LFS/sources

rm -rf bash-5.2.15
