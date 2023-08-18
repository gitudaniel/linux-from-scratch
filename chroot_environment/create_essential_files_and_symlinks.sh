#!/bin/bash

# Modern kernels maintain a list of mounted filesystems internally and expose it to the
# user via the /proc filesystem.
# Create the following symbolic link to satisfy utilities that expect to find /etc/mtab file
ln -sv /proc/self/mounts /etc/mtab


# Create a basic /etc/hosts file to be referenced in some test suites and one of Perl's configuration files
cat > /etc/hosts << EOF
127.0.0.1 localhost $(hostname)
::1       localhost
EOF


# In order for user root to be able to login and for the name "root" to be recognized, there
# must be relevant entries in the /etc/passwd and /etc/group files

# Create the /etc/passwd file. The actual password for root will be set later
cat > /etc/passwd << "EOF"
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/dev/null:/usr/bin/false
daemon:x:6:6:Daemon User:/dev/null:/usr/bin/false
messagebus:x:18:18:D-Bus Message Daemon User:/run/dbus:/usr/bin/false
uuidd:x:80:80:UUID Generation Daemon User:/dev/null:/usr/bin/false
nobody:x:65534:65534:Unprivileged User:/dev/null:/usr/bin/false
EOF

# Create the /etc/group file
cat > /etc/group << "EOF"
root:x:0:
bin:x:1:daemon
sys:x:2:
kmem:x:3:
tape:x:4:
tty:x:5:
daemon:x:6:
floppy:x:7:
disk:x:8:
lp:x:9:
dialout:x:10:
audio:x:11:
video:x:12:
utmp:x:13:
usb:x:14:
cdrom:x:15:
adm:x:16:
messagebus:x:18:
input:x:24:
mail:x:34:
kvm:x:61:
uuidd:x:80:
wheel:x:97:
users:x:999:
nogroup:x:65534:
EOF


# Add a regular user since some tests in chapter 8 need a regular user.
# This account will be deleted at the end of that chapter
echo "tester:x:101:101::/home/tester:/bin/bash" >> /etc/passwd
echo "tester:x:101:" >> /etc/group
install -o tester -d /home/tester


# Start a new shell to remove the "I have no name!" prompt
# Since the /etc/passwd and /etc/group files have been created, user name and group name resolution will now work
exec /usr/bin/bash --login


# Initialize log files and give them proper permissions
# This allows programs to record information such as who was logged into the system and when
# /var/log/wtmp records all logins and logouts
# /var/log/lastlog records when each user last logged in
# /var/log/faillog records failed login attempts
# /var/log/btmp records bad login attempts
touch /var/log/{btmp,lastlog,faillog,wtmp}
chgrp -v utmp /var/log/lastlog
chmod -v 664 /var/log/lastlog
chmod -v 600 /var/log/btmp
