#!/bin/bash

# run the following commands as user root
mkdir -pv $LFS
mount -v -t ext4 /dev/<xxx> $LFS

# The following commands ensure that the LFS partition is automatically mounted
# in the event of a reboot
echo 'dev/vda4 /mnt/lfs ext4 defaults      1       1' >> /etc/fstab
