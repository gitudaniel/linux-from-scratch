#!/bin/bash

echo "Starting installation of Vim"

tar -xf vim-9.0.1273.tar.xz
cd vim-9.0.1273

# Change the default location of the vimrc configuration file to /etc
echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h

./configure --prefix=/usr

make

# To prepare tests, ensure that the user tester can write to the source tree
chown -Rv tester .

# Run the tests as user tester
# A successful test will result in the words "ALL DONE" in the log file at completion
su tester -c "LANG=en_US.UTF-8 make -j1 test" &> vim-test.log


if grep -q 'ALL DONE' vim-test.log; then
    echo "All tests successfully completed. Proceeding with installation"
else
    echo "Tests did not complete successfully. Please verify the issue and try again"
    exit 1
fi

make install

# Allow execution of vim when users habitually enter vi by creating a symlink for both the
# binary and the manpage in the provided languages
ln -sv vim /usr/bin/vi
for L in /usr/share/man/{,*/}man1/vim.1; do
    ln -sv vim.1 $(dirname $L)/vi.1
done

# By default Vim's documentation is installed in /usr/share/vim.
# The symlink below allows the documentation to be accessed via /usr/share/doc/vim-9.0.1273,
# making it consistent with the location of documentation for other packages
ln -sv ../vim/vim90/doc /usr/share/doc/vim-9.0.1273


# Create a default vim configuration file
cat > /etc/vimrc << "EOF"
" Begin /etc/vimrc

" Ensure defaults are set before customizing settings, not after
source $VIMRUNTIME/defaults.vim
let skip_defaults_vim=1

set nocompatible
set backspace=2
set mouse=
syntax on
if (&term == "xterm") || (&term == "putty")
  set background=dark
endif

" End /etc/vimrc
EOF

echo "Finished installation of Vim"

cd $LFS/sources
rm -rf vim-9.0.1273
