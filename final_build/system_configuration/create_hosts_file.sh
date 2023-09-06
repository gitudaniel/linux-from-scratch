#!/bin/bash

echo "Creating /etc/hosts file"

# A hosts file is necessary for certain programs to operate correctly
# My hosts file does not conform to the pattern outlined in the LFS
# book. I changed it to conform to the format the host machine's
# /etc/hosts file.
cat > /etc/hosts << "EOF"
# Begin /etc/hosts

127.0.0.1 localhost
127.0.1.1 lfs

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters


# End /etc/hosts
EOF

echo "Created /etc/hosts/ file"
