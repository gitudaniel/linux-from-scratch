#!/bin/bash

echo "Starting installation of Util-linux"

tar -xf util-linux-2.38.1.tar.xz
cd util-linux-2.38.1

# The --disable and --without options prevent warnings about building
# components that either require packages not in LFS, or are inconsistent
# with programs installed by other packages.
./configure ADJTIME_PATH=/var/lib/hwclock/adjtime \
            --bindir=/usr/bin    \
            --libdir=/usr/lib    \
            --sbindir=/usr/sbin  \
            --disable-chfn-chsh  \
            --disable-login      \
            --disable-nologin    \
            --disable-su         \
            --disable-setpriv    \
            --disable-runuser    \
            --disable-pylibmount \
            --disable-static     \
            --without-python     \
            --without-systemd    \
            --without-systemdsystemunitdir \
            --docdir=/usr/share/doc/util-linux-2.38.1

make

# The hardlink tests will fail if the host's kernel does not have the option
# CONFIG_CRYPTO_USER_API_HASH set.
# In addition, two sub-tests from misc: mbsencode and one sub-test from script: replay
# are known to fail.
chown -Rv tester .
su tester -c "make -k check"

make install

echo "Finished installation of Util-linux"

cd $LFS/sources
rm -rf util-linux-2.38.1
