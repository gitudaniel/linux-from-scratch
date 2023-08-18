# sudo privileges required
grep -q '/mnt/lfs' /etc/fstab || printf '/dev/<xxx> /mnt/lfs ext4     defaults      1       1\n' >> /etc/fstab
