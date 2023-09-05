#!/bin/bash

# During the boot process, the file /etc/hostname is used for establishing
# the sytem's hostname
# Create the file below
# Replace lfs with your chosen hostname
echo "lfs" > /etc/hostname

echo "Created /etc/hostname file"
