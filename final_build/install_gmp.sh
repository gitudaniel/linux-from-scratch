#!/bin/bash

echo "Starting installation of GMP"

tar -xf gmp-6.2.1.tar.xz
cd gmp-6.2.1

./configure --prefix=/usr    \
            --enable-cxx     \
            --disable-static \
            --docdir=/usr/share/doc/gmp-6.2.1

# Compile the package
make

# Generate HTML documentation
make html

# Test the results
make check 2>&1 | tee /tmp/gmp-check-log

# The test suite for gmp is considered critical.
# Check the results to ensure that all 197 tests passed before continuing with installation.
if [[ $(awk '/# PASS:/{total+=$3} ; END{print total}' /tmp/gmp-check-log) -eq 197 ]]; then
  echo "All tests passed. Proceeding with installation"

  # Install the package
  make install
  
  # Install documentation
  make install-html
  
  echo "Finished installation of GMP"
  
  cd $LFS/sources
  rm -rf gmp-6.2.1

else
  echo "Test failures recorded. Please confirm with gmp-check-log and fix the issues then try again"

fi

