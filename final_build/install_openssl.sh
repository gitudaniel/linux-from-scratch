#!/bin/bash

echo "Starting installation of OpenSSL"

tar -xf openssl-3.0.8.tar.gz
cd openssl-3.0.8

./config --prefix=/usr         \
         --openssldir=/etc/ssl \
         --libdir=lib          \
         shared
         zlib-dynamic

make

# 30-test_afalg.t is known to fail on some kernel configurations.
# It can safely be ignored.
make test

# Install
sed -i '/INSTALL_LIBS/s/libcrypto.a libssl.a//' Makefile
make MANSUFFIX=ssl install

# Add the version to the documentation directory name, to be consistent
# with other packages
mv -v /usr/share/doc/openssl /usr/share/doc/openssl-3.0.8

# Install additional documentation
cp -vfr doc/* /usr/share/doc/openssl-3.0.8

echo "Finished installation of OpenSSL"

cd $LFS/sources
rm -rf openssl-3.0.8
