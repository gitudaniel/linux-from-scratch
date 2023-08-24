#!/bin/bash

echo "Starting installation of XML-Parser"

tar -xf XML-Parser-2.46.tar.gz
cd XML-Parser-2.46

# Configure
perl Makefile.PL

make

make test

make install

echo "Finished installation of XML-Parser"

cd $LFS/sources
rm -rf XML-Parser-2.46
