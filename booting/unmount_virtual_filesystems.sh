#!/bin/bash

echo "Start unmounting file systems"

# I did not use multiple partitions
umount -v $LFS/dev/pts
mountpoint -q $LFS/dev/shm && umount $LFS/dev/shm
umount -v $LFS/dev
umount -v $LFS/run
umount -v $LFS/proc
umount -v $LFS/sys

# Unmount the LFS file itself
umount -v $LFS

echo "Finished unmounting file systems"


