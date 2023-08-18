#!/bin/bash

# Run commands as user root

# Check for presence of /etc/bash.bashrc and move it out of the way
# This file has the potential to modify the lfs user's environment in ways
# that can affect the building of critical LFS packages
# When the lfs user is no longer needed (beginning of Chapter 7), this file
# may be restored if desired
[ ! -e /etc/bash.bashrc ] || mv -v /etc/bash.bashrc /etc/bash.bashrc.NOUSE
