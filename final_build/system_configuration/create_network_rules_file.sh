#!/bin/bash

echo "Starting generation of network rules"

# The script below generates the initial rules for naming network devices.
# This naming convention ensures that network devices are named consistently,
# not based on when the network card was discovered.
bash /usr/lib/udev/init-net-rules.sh

echo "Finished generation of network rules"

# Inspect the /etc/udev/rules.d/70-persistent-net.rules file to find out which
# name was assigned to which network device.
# NOTE: In cases where the MAC addresses are assigned manually or in a virtual
# environment, the network rules file may not be generated because addresses
# are not consistently assigned.
# This method cannot be used in my case since I am building LFS on a Qemu
# virtual machine.
cat /etc/udev/rules.d/70-persistent-net.rules
