#!/bin/bash

echo "Starting creation of GRUB configuration file"

# Be very careful about the hard disk designation.
# I didn't use a separate boot partition.
# The partition I was building LFS on was vda4, therefore according to GRUB
# naming conventions this will be (hd0,4).
# Be sure to alter set root=(hd0,4) and /boot/vmlinuz-6.1.11-lfs-11.3 root=/dev/vda4 ro
# for your specific set up.
cat > /boot/grub/grub.cfg << "EOF"
# Begin /boot/grub/grub.cfg
set default=0
set timeout=5

insmod ext2
set root=(hd0,4)

menuentry "GNU/Linux, Linux 6.1.11-lfs-11.3" {
        linux   /boot/vmlinuz-6.1.11-lfs-11.3 root=/dev/vda4 ro
}
EOF

echo "Finished creation of GRUB configuration file"
