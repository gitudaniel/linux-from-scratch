#!/bin/sh

# All commands are run as root
# If you leave the chroot environment for any reason e.g. rebooting
# rerun this script before continuing with installation.

# Bind mount the host system's /dev directory to $LFS/dev.
# This is the only host-agnostic way to populate the $LFS/dev directory
mount -v --bind /dev $LFS/dev

# Mount the remaining virtual kernel file systems
mount -v --bind /dev/pts $LFS/dev/pts
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
mount -vt tmpfs tmpfs $LFS/run

# If /dev/shm is a mount point for a tmpfs, the mount of /dev above will only
# create /dev/shm as a directory in the chroot environment.
# In this situation we must explicitly mount a tmpfs
if [ -h $LFS/dev/shm ]; then
  mkdir -pv $LFS/$(readlink $LFS/dev/shm)
else
  mount -t tmpfs -o nosuid,nodev tmpfs $LFS/dev/shm
fi

# Commands to enter chroot environment.
chroot "$LFS" /usr/bin/env -i    \
    HOME=/root                   \
    TERM="$TERM"                 \
    PS1='(lfs chroot) \u:\w\$ '  \
    PATH=/usr/bin:/usr/sbin      \
    /bin/bash --login
