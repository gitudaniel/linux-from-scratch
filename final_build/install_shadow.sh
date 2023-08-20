#!/bin/bash

echo "Starting installation of Shadow"

tar -xf shadow-4.13.tar.xz
cd shadow-4.13

# Skipped the installation of CrackLib for the sake of simplicity
# If you already have the package downloaded head over to
# https://www.linuxfromscratch.org/blfs/view/11.3/postlfs/cracklib.html
# and follow the instructions provided.

# Disable the installation of the groups program and its manpages.
# Coreutils provides a better version.
# Also, prevent installation of manual pages that were already installed
sed -i 's/groups$(EXEEXT) //' src/Makefile.in
find man -name Makefile.in -exec sed -i 's/groups\.1 / /'   {} \;
find man -name Makefile.in -exec sed -i 's/getspnam\.3 / /' {} \;
find man -name Makefile.in -exec sed -i 's/passwd\.5 / /'   {} \;

# Use the more secure SHA-512 password encryption method as opposed to the default crypt method
# Set the number of rounds to 500,000 instead of the default 5000.
# The default is too low to prevent brute force password attacks.
# Change the obsolete /var/spool/mail location for user mailboxes Shadow uses by default
# to the /var/mail location currently used.
# Remove /bin and /sbin from the PATH since they are symlinks to their counterparts in /usr.
sed -e 's:#ENCRYPT_METHOD DES:ENCRYPT_METHOD SHA512:' \
    -e 's@#\(SHA_CRYPT_..._ROUNDS 5000\)@\100@'       \
    -e 's:/var/spool/mail:/var/mail:'                 \
    -e '/PATH=/{s@/sbin:@@;s@/bin:@@}'                \
    -i etc/login.defs

# Configure
# If CrackLib is installed add --with-libcrack here
touch /usr/bin/passwd
./configure --sysconfdir=/etc \
            --disable-static  \
            --with-group-name-max-length=32

# Compile
make

# This package does not come with a test suite
# Install
make exec_prefix=/usr install
make -C man install-man

# Enable shadowed passwords
# To find out more about shadowed passwords visit https://www.techtarget.com/searchsecurity/definition/shadow-password-file
pwconv

# Enable shadowed group passwords
grpconv

# Create the /etc/default/useradd file
mkdir -p /etc/default
useradd -D --gid 999

# Choose and set a password for user root
passwd root

echo "Finished installation of Shadow"

cd $LFS/sources
rm -rf shadow-4.13
