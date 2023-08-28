#!/bin/bash

echo "Starting installation of Sysklogd"

tar -xf sysklogd-1.5.1.tar.gz
cd sysklogd-1.5.1

# Fix a problem that causes a segmentation fault in klogd under some conditions.
# Fix an obsolete program construct.
sed -i '/Error loading kernel symbols/{n;n;d}' ksym_mod.c
sed -i 's/union wait/int/' syslogd.c

make

# This package does not come with a test suite

make BINDIR=/sbin install

# Create a new /etc/syslog.conf file
cat > /etc/syslog.conf << "EOF"
# Begin /etc/syslog.conf

auth,authpriv.* -/var/log/auth.log
*.*;auth,authpriv.none -/var/log/sys.log
daemon.* -/var/log/daemon.log
kern.* -/var/log/kern.log
mail.* -/var/log/mail.log
user.* -/var/log/user.log
*.emerg *

# End /etc/syslog.conf
EOF

echo "Finished installation of Sysklogd"

cd $LFS/sources
rm -rf sysklogd-1.5.1
