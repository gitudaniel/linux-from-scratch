#!/bin/bash

echo "Starting installation of the Linux kernel"

tar -xf linux-6.1.11.tar.xz
cd linux-6.1.11

# Prepare for compilation
# This ensures that the kernel tree is absolutely clean.
make mrproper

# Set the base configuration to a good state that takes your current system
# architecture into account
make defconfig

# Compile kernel image and modules
make

# Install kernel modules
make modules_install

# NOTE: I am not using a separate boot partition for the LFS system.
# Refer to the Caution section in Chapter 10.3.1 if you are
# Path to kernel image
cp -iv arch/x86/boot/bzImage /boot/vmlinuz-6.1.11-lfs-11.3

# Install the map file.
# System.map is a symbol file for the kernel.
# It maps the function entry points for every function in the kernel API, as
# well as the addresses of the kernel data structures for the running kernel.
# It is used as a resource when investigating kernel problems
cp -iv System.map /boot/System.map-6.1.11

# The kernel configuration file .config produced by the make menuconfig step above
# contains all the configuration selections for the kernel that was just compiled.
# Keep this file for future reference.
cp -iv .config /boot/config-6.1.11

# Install documentation
install -d /usr/share/doc/linux-6.1.11
cp -r Documentation/* /usr/share/doc/linux-6.1.11

# I'm retaining the kernel source tree.
# ensure all files are owned by root
chown -R 0:0 ../linux-6.1.11

echo "Finished installation of the Linux kernel"

cd $LFS/sources
