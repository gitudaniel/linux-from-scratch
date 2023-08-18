#!/bin/bash

# This package together with Expect and DejaGNU are installed to support the
# test suites for Binutils, GCC and other packages.
# It is very reassuring to know that the most important tools are working properly

echo "Starting installation of Tcl"

tar -xf tcl8.6.13-src.tar.gz
cd tcl8.6.13

# Prepare for compilation
SRCDIR=$(pwd)
cd unix
./configure --prefix=/usr            \
            --mandir=/usr/share/man

# Build the package
make

# The various "sed" instructions remove references to the build directory from the
# configuration files and replace them with the install directory.
# This is not mandatory for the remainder of LFS, but may be needed if a package
# built later uses Tcl
sed -e "s|$SRCDIR/unix|/usr/lib|" \
    -e "s|$SRCDIR|/usr/include|"  \
    -i tclConfig.sh

sed -e "s|$SRCDIR/unix/pkgs/tdbc1.1.5|/usr/lib/tdbc1.1.5|" \
    -e "s|$SRCDIR/pkgs/tdbc1.1.5/generic|/usr/include|"    \
    -e "s|$SRCDIR/pkgs/tdbc1.1.5/library|/usr/lib/tcl8.6|" \
    -e "s|$SRCDIR/pkgs/tdbc1.1.5|/usr/include|"            \
    -i pkgs/tdbc1.1.5/tdbcConfig.sh

sed -e "s|$SRCDIR/unix/pkgs/itcl4.2.3|/usr/lib/itcl4.2.3|" \
    -e "s|$SRCDIR/pkgs/itcl4.2.3/generic|/usr/include|"    \
    -e "s|$SRCDIR/pkgs/itcl4.2.3|/usr/include|"            \
    -i pkgs/itcl4.2.3/itclConfig.sh

unset SRCDIR

# Test the results
make check

# Install the package
make install

# Make the installed library writable so debugging symbols can be removed later
chmod -v u+w /usr/lib/libtcl8.6.so

# Install Tcl's headers. The Expect package requires them
make install-private-headers

# Make a necessary symbolic link
ln -sfv tclsh8.6 /usr/bin/tclsh

# Rename a man page that confilcts with a Perl man page
mv /usr/share/man/man3/{Thread,Tcl_Thread}.3

# Install documentation
cd ..
tar -xf ../tcl8.6.13-html.tar.gz --strip-components=1
mkdir -v -p /usr/share/doc/tcl-8.6.13
cp -v -r ./html/* /usr/share/doc/tcl-8.6.13

echo "Finished installation of Tcl"

cd $LFS/sources
rm -rf {tcl8.6.13, tcl8.6.13-html}
