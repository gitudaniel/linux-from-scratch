#!/bin/bash

# Create root-level directories that are not in the limited set required in the previous chapters
mkdir -pv /{boot,home,mnt,opt,srv}

# Create the required set of subdirectories below the root-level
mkdir -pv /etc/{opt,sysconfig}
mkdir -pv /lib/firmware
mkdir -pv /media/{floppy,cdrom}
mkdir -pv /usr/{,local/}{include,src}
mkdir -pv /usr/local/{bin,lib,sbin}
mkdir -pv /usr/{,local/}share/{color,dict,doc,info,locale,man}
mkdir -pv /usr/{,local/}share/{misc,terminfo,zoneinfo}
mkdir -pv /usr/{,local/}share/man/man{1..8}
mkdir -pv /var/{cache,local,log,mail,opt,spool}
mkdir -pv /var/lib/{color,misc,locate}

ln -sfv /run /var/run
ln -sfv /run/lock /var/lock

# Ensure that not just anybody can enter the /root directory
install -dv -m 0750 /root
# Ensure that any user can write to the /tmp and /var/tmp directories
# but cannot remove another user's files from them.
# This is prohibited by the "sticky bit", the highest bit (1) in the 1777 bit mask
install -dv -m 1777 /tmp /var/tmp
