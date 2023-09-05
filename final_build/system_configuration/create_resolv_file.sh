#!/bin/bash

echo "Starting creation of /etc/resolv.conf file"

# Placing the IP address of the DNS server enables the system to resolve
# Internet domain names to IP addresses and vice versa
# Removed domain entry. See: https://unix.stackexchange.com/a/128096
# Removed the second nameserver entry. I only need one DNS server.
# For the nameserver entry, refer to the /etc/resolv.conf file on the host/VM.
cat > /etc/resolv.conf << "EOF"
# Begin /etc/resolv.conf
nameserver <IP address of your primary nameserver>
# End /etc/resolv.conf
EOF

echo "Finished creation of /etc/resolv.conf file"
