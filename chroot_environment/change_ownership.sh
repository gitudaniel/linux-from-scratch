#!/bin/sh

# All commands are run as root

# Change ownership of the $LFS/* directories to user root.
# Prevents possible malicious manipulation because the directories and files
# under $LFS are owned by a user ID without a corresponding account.
# A user account created later could get this same user ID and would own all
# the files under $LFS.
chown -R root:root $LFS/{usr,lib,var,etc,bin,sbin,tools}
case $(uname -m) in
  x86_64) chown -R root:root $LFS/lib64 ;;
esac

# Create directories on which virtual file systems will be mounted.
# These virtual file systems are utilized by application running in userspace
# to communicate with the kernel
mkdir -pv $LFS/{dev,proc,sys,run}
