#!/bin/bash

echo "Starting creation of /etc/profile file"

# Set environment variables necessary for native language support for bash
# This file and the ~/.bash_profile are read when the shell is invoked as
# an interactive login shell
# Assumes locale tests have already been performed
# en_US is the format I went for, no modifiers were used. YMMV
cat > /etc/profile << "EOF"
# Begin /etc/profile

export LANG=en_US.iso88591

# End /etc/profile
EOF

echo "Finished creation of /etc/profile file"
