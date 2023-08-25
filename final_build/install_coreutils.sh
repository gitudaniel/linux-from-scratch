#!/bin/bash

echo "Starting installation of Coreutils"

tar -xf coreutils-9.1.tar.xz
cd coreutils-9.1

# POSIX requires that programs from Coreutils recognize character boundaries
# correctly even in multibyte locales.
# The following patch fixes this non-compliance and other internationalization
# related bugs.
patch -Np1 -i ../coreutils-9.1-i18n-1.patch

# Prepare Coreutils for compilation
autoreconf -fiv
FORCE_UNSAFE_CONFIGURE=1 ./configure \
            --prefix=/usr
            --enable-no-install-program=kill,uptime

# Compile
make

# Run tests meant to be run as user root
make NON_ROOT_USERNAME=tester check-root

# The remainder of the test suite will be run as the tester user.
# Certain tests require that the user be a member of more than one group.
# To ensure these tests are not skipped, add a temporary group and make the
# user tester a member
echo "dummy:x:102:tester" >> /etc/group

# Fix some of the permissions so that the non-root user can compile and run tests
chown -Rv tester .

# Run tests
# The test-getlogin may fail in the LFS chroot environment
su tester -c "PATH=$PATH make RUN_EXPENSIVE_TESTS=yes check"

# Remove the temporary group
sed -i '/dummy/d' /etc/group

# Install
make install

# Move programs to the locations specified by the FHS
mv -v /usr/bin/chroot /usr/sbin
mv -v /usr/share/man/man1/chroot.1 /usr/share/man/man8/chroot.8
sed -i 's/"1"/"8"/' /usr/share/man/man8/chroot.8

echo "Finished installation of Coreutils"

cd $LFS/sources
rm -rf coreutils-9.1
