#!/bin/bash

echo "Creating /etc/sysconfig/clock file"

# For reference see https://superuser.com/a/773336 and https://tldp.org/HOWTO/TimePrecision-HOWTO/set.html

cat > /etc/sysconfig/clock << "EOF"
# Begin /etc/sysconfig/clock

UTC=1

# Set this to any options you might need to give to hwclock,
# such as machine hardware clock type for Alphas.
ZONE="Africa/Nairobi"
ARC=false

# End /etc/sysconfig/clock
EOF

echo "Created /etc/sysconfig/clock file"
