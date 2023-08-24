#!/bin/bash

echo "Starting installation of Python"

tar -xf Python-3.11.2.tar.xz
cd Python-3.11.2

./configure --prefix=/usr       \
            --enable-shared     \
            --with-system-expat \
            --with-system-ffi   \
            --enable-optimizations

make

# Running tests at this point is not recommended.
# The tests are known to hang indefinitely in the partial LFS environment.

make install

# pip3 is used to install Python 3 programs and modules for all users as root
# in several places.
# Running pip3 install as a non-root user may seem to work, but it will cause
# the installed module to be inaccessible by other users.
# The Python developer's recommendation is to install packages into a virtual
# environment or into the home directory of a regular user by running pip3
# as this user.
# The main reason for the recommendation is to avoid conflicts with the system's
# package manager e.g. dpkg.
# LFS does not have a system wide package manager, so this is not a problem.
# pip3 will check for a new version of itself whenever it's run.
# LFS considers pip3 to be a part of Python 3 so it should not be updated separately.
# Supress warnings about updating to a new version of pip3.
cat > /etc/pip.conf << EOF
[global]
root-user-action = ignore
disable-pip-version-check = true
EOF

# Install the preformatted documentation
install -v -dm755 /usr/share/doc/python-3.11.2/html

tar --strip-components=1  \
    --no-same-owner       \
    --no-same-permissions \
    -C /usr/share/doc/python-3.11.2/html \
    -xvf ../python-3.11.2-docs-html.tar.bz2

echo "Finished installation of Python"

cd $LFS/sources
rm -rf Python-3.11.2
