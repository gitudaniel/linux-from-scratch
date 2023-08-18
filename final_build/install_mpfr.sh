#!/bin/bash

echo "Starting installation of MPFR"

tar -xf mpfr-4.2.0.tar.xz
cd mpfr-4.2.0

# Fix a test case based on a bug of old Glibc releases
sed -e 's/+01,234,567/+1,234,567 /' \
    -e 's/13.10Pd/13Pd/'            \
    -i tests/tsprintf.c

# Prepare for compilation
./configure --prefix=/usr        \
            --disable-static     \
            --enable-thread-safe \
            --docdir=/usr/share/doc/mpfr-4.2.0

# Compile the package and generate HTML documentation
make
make html

# Test the results
make check 2>&1 | tee /tmp/mpfr-check-log

# The test suite for gmp is considered critical.
# Check the results to ensure that all 197 tests passed before continuing with installation.
if [[ $(awk '/# PASS:/{total+=$3} ; END{print total}' /tmp/gmp-check-log) -eq 197 ]]; then
  echo "All tests passed. Proceeding with installation"

  # Install the package
  make install
  
  # Install documentation
  make install-html
  
  echo "Finished installation of MPFR"
  
  cd $LFS/sources
  rm -rf mpfr-4.2.0

else
  echo "Test failures recorded. Please confirm with mpfr-check-log and fix the issues then try again"

fi
