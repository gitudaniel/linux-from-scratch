#!/bin/bash

echo "Creating /etc/modprobe.d/usb.conf file"

# modprobe or insmod (the program that loads modules), uses
# /etc/modprobe.d/usb.conf for specific direction when loading linux modules.
# This file needs to be created so that if the USB drivers have been built as
# modules, they will be loaded in the correct order.
# This avoids a warning being output at boot time

install -v -m755 -d /etc/modprobe.d
cat > /etc/modprobe.d/usb.conf << "EOF"
# Begin /etc/modprobe.d/usb.conf

install ohci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i ohci_hcd ; true
install uhci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i uhci_hcd ; true

# End /etc/modprobe.d/usb.conf
EOF

echo "Created /etc/modprobe.d/usb.conf file"
