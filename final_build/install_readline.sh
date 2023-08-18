#!/bin/bash

echo "Starting installation of Readline"

tar -xf readline-8.2.tar.gz
cd readline-8.2

# Prevent old libraries being moved to <libraryname>.old
# This occurs when reinstalling Readline and in some cases it
# triggers a liking bug in ldconfig.
# The below two seds avoid this.
sed -i '/MV.*old/d' Makefile.in
sed -i '/{OLDSUFF}/c:' support/shlib-install

# Fix a problem identified upstream
patch -Np1 -i ../readline-8.2-upstream_fix-1.patch

# Prepare for compilation
./configure --prefix=/usr    \
            --disable-static \
            --with-curses    \
            --docdir=/usr/share/doc/readline-8.2

# Compile the package
make SHLIB_LIBS="-lncursesw"  # forces readline to link against the libncursesw library

# Install the package. Does not come with test suite
make SHLIB_LIBS="-lncursesw" install

# Install documentation
install -v -m644 doc/*.{ps,pdf,html,dvi} /usr/share/doc/readline-8.2

echo "Finished installation of Readline"

cd $LFS/sources
rm -rf readline-8.2.tar.gz
