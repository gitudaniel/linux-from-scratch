#!/bin/bash

echo "Starting creation of /etc/shells file"

# The shells file contains a list of login shells on the system.
# Applications use this file to determine whether a shell is valid.
# For each shell a single line should be present, consisting of the shell's
# path relative to the root of the directory structure (/).
# This file is consulted by cshs to determine whether an unprivileged user may
# change the login shell for their own account.
# If the command name is not listed the user will be denied the ability to change
# shells.
cat > /etc/shells << "EOF"
# Begin /etc/shells

/bin/sh
/bin/bash

# End /etc/shells
EOF

echo "Finished creation of /etc/shells file"
