#!/bin/bash

echo "Starting installation of LFS bootscripts"

tar -xf lfs-bootscripts-20230101.tar.xz
cd lfs-bootscripts-20230101

make install

echo "Finished installation of LFS bootscripts"

cd $LFS/sources
rm -rf lfs-bootscripts-20230101
