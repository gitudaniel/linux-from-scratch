#!/bin/bash

echo "Starting installation of Meson"

tar -xf meson-1.0.0.tar.gz
cd meson-1.0.0

# Compile
pip3 wheel -w dist --no-build-isolation --no-deps $PWD

# The test suite requires some packages outside the scope of LFS

# Install
pip3 install --no-index --find-links dist meson
install -vDm644 data/shell-completions/bash/meson /usr/share/bash-completion/completions/meson
install -vDm644 data/shell-completions/zsh/_meson /usr/share/zsh/site-functions/_meson

echo "Finished installation of Meson"

cd $LFS/sources
rm -rf meson-1.0.0
