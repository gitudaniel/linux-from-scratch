#!/bin/bash

echo "Starting installation GRUB files"

# Be sure to use the disk designations used on your VM
# Mine were vda instead of sda
grub-install /dev/vda

echo "Finished installation of GRUB files"
