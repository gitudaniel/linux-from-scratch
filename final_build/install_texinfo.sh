#!/bin/bash

echo "Starting installation of Texinfo"

tar -xf texinfo-7.0.2.tar.xz
cd texinfo-7.0.2

./configure --prefix=/usr

make

make check

make install

# Install the components belonging in a TeX installation
make TEXMF=/usr/share/texmf install-tex

# The info documentation system uses a plain text file to hold its list of menu entries.
# Due to occasional problems in the Makefiles of various packages, it can sometimes
# get out of sync with the info pages installed in the system.
# If the /usr/share/info/dir file ever needs to be recreated the below optional commands
# will accomplish the task
## pushd /usr/share/info
##   rm -v dir
##   for f in *
##     do install-info $f dir 2>/dev/null
##   done
## popd

echo "Finished installation of Texinfo"

cd $LFS/sources
rm -rf texinfo-7.0.2
