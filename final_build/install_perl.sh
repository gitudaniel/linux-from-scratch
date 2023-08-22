#!/bin/bash

echo "Starting installation of Perl"

tar -xf perl-5.36.0.tar.xz
cd perl-5.36.0

# The following command instructs Perl to use the libraries installed
# on the system and not an internal copy of the sources for the build
export BUILD_ZLIB=False
export BUILD_BZIP2=0

# The command below uses defaults that Perl auto-detects.
# Remove the "-des" option and hand-pick the way this package is built.
sh Configure -des                                            \
             -Dprefix=/usr                                   \
             -Dvendorprefix=/usr                             \
             -Dprivlib=/usr/lib/perl5/5.36/core_perl         \
             -Darchlib=/usr/lib/perl5/5.36/core_perl         \
             -Dsitelib=/usr/lib/perl5/5.36/site_perl         \
             -Dsitearch=/usr/lib/perl5/5.36/site_perl        \
             -Dvendorlib=/usr/lib/perl5/5.36/vendor_perl     \
             -Dvendorarch=/usr/lib/perl5/5.36/vendor_perl    \
             -Dman1dir=/usr/share/man/man1                   \
             -Dman3dir=/usr/share/man/man3                   \
             -Dpager="/usr/bin/less -isR"                    \
             -Duseshrplib                                    \
             -Dusethreads

make

make test

# Install the package and clean up
make install
unset BUILD_ZLIB BUILD_BZIP2

echo "Finished installation of Perl"

cd $LFS/sources
rm -rf perl-5.36.0
