#!/bin/bash

echo "Starting installation of Wheel"

tar -xf wheel-0.38.4.tar.gz
cd wheel-0.38.4

# Compile
PYTHONPATH=src pip3 wheel -w dist --no-build-isolation --no-deps $PWD

# Install
pip3 install --no-index --find-links=dist wheel

echo "Finished installation of Wheel"

cd $LFS/sources
rm -rf wheel-0.38.4
