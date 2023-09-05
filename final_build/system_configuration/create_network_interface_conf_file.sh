#!/bin/bash

echo "Creating network interface configuration file"

# In my setup I was unable to create custom udev rules for network devices
# since I'm building LFS on a Qemu virtual machine.
# This means that udev will assign network card interface names based on
# system physical characteristics such as enp2s1.
# To confirm your interface name run `ip link` or `ls /sys/class/net` after
# booting the LFS system.
# Create a sample file for the eth0 device with a static IP address
# Change the values for IP, GATEWAY, PREFIX, and BROADCAST to suit your setup
# For your specific values refer to the below stack overflow questions
# https://askubuntu.com/a/197637
# https://askubuntu.com/a/947180
cd /etc/sysconfig/
cat > ifconfig.eth0 << "EOF"
ONBOOT=yes
IFACE=eth0
SERVICE=ipv4-static
IP=192.168.1.2
GATEWAY=192.168.1.1
PREFIX=24
BROADCAST=192.168.1.255
EOF

echo "Finished creating network interface configuration file"

cd $LFS/sources
