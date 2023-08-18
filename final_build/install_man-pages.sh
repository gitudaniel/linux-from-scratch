#!/bin/bash

echo "Starting installation of Man-pages"

tar -xf man-pages-6.03.tar.xz
cd man-pages-6.03

make prefix=/usr install

echo "Finished installation of Man-pages"

cd $LFS/sources
rm -rf man-pages-6.0.3
