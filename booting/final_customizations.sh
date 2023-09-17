#!/bin/bash

echo "Starting final customizations"

# Tag the lfs system with a release version file
echo 11.3 > /etc/lfs-release

# Show the status of lfs with respect to the Linux Standards Base (LSB)
cat > /etc/lsb-release << "EOF"
DISTRIB_ID="Linux From Scratch"
DISTRIB_RELEASE="11.3"
DISTRIB_CODENAME="lfs1.0"
DISTRIB_DESCRIPTION="Linux From Scratch"
EOF

# OS information used by systemd and some graphical desktop environments
cat > /etc/os-release << "EOF"
NAME="Linux From Scratch"
VERSION="11.3"
ID=lfs
PRETTY_NAME="Linux From Scratch 11.3"
VERSION_CODENAME="lfs1.0"
EOF

echo "Finished final customizations"
