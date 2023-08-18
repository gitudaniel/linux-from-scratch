#!/bin/bash

# Run all commands as root

mkdir -v $LFS/sources
chmod -v a+wt $LFS/sources  # make the directory writable and sticky

# Download packages
wget --input-file=wget-list-sysv --continue --directory-prefix=$LFS/sources

# Verify pakcages
pushd $LFS/sources
  md5sum -c md5sums
popd
