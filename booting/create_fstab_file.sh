#!/bin/bash

echo "Starting creation of the /etc/fstab file"

# The /etc/fstab file is used by some programs to determine where file systems
# are to be mounted by default, in which order, and which must be checked
# (for integrity errors) prior to mounting.
# Be sure to change partition values to match your system.
cat > /etc/fstab << "EOF"
# Begin /etc/fstab

# file system  mount-point  type      options              dump  fsck
#                                                                order

/dev/vda4      /            ext4      defaults             1     1
/dev/vda5      swap         swap      pri=1                0     0
proc           /proc        proc      nosuid,noexec,nodev  0     0
sysfs          /sys         sysfs     nosuid,noexec,nodev  0     0
devpts         /dev/pts     devpts    gid=5,mode=620       0     0
tmpfs          /run         tmpfs     defaults             0     0
devtmpfs       /dev         devtmpfs  mode=0755,nosuid     0     0
tmpfs          /dev/shm     tmpfs     nosuid,nodev         0     0

# End /etc/fstab
EOF

echo "Finished creation of the /etc/fstab file"
