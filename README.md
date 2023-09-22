# Linux From Scratch
Scripts for installing Linux from scratch on a minimal installation of ubuntu 22.04. Follows Linux From Scratch version 11.3

LFS (Linux From Scratch) was installed on a qemu virtual machine as a precaution. I wanted to be able to work on LFS without risking my host system.

[Guide](https://help.ubuntu.com/community/KVM/Installation) on how to install KVM

LFS is installed on a single partition. From my experience I'd recommend using ubuntu server instead of a minimal installation like I did.
None of the GUI components of Ubuntu are required and it will save on space used for installation of Ubuntu.

The partition on which you're going to install LFS should already be in ext4 format.

When creating the VM (Virtual Machine), I created a swap partition. This swap partition is the same one used when installing LFS.

Ensure that software from the main, universe, multiverse and restricted repositories are downloadable. The `version_check.sh` file required packages had to be downloaded.

While the book assumes that installation is done in one continuous sprint, it rightly points out that this may not be practically feasible. I used VM snapshots as a safety precaution.
Snapshots saved me from having to start from scratch more than once. I could determine where a mistake had been made and reset the VM to a specific snapshot.

As a precaution create snapshots at the end of every chapter from chapter 3 onwards. While the scripts in this repo worked for me caution is always advised since mistakes are inevitable.

### Verifying general compilation instructions
Use the following command to verify that bash is the shell in use ([source](https://askubuntu.com/a/590902)):
  ```sh
  echo $0
  ```

Use the following command to verify that symbolic links for the shell you are using are as they should be ([source](https://stackoverflow.com/a/37423392)):
  ```sh
  readlink -f $(command -v sh)
  ```

Ubuntu 22 tends to point sh to dash not bash. In this case:
  ```sh
  sudo ln -sf bash /bin/sh
  ```

  ### Copying scripts to the VM
Create the `~.ssh/config` file on the host machine and add the following:
  ```sh
  Host <recognizable_name>
      User <your_username>
      Hostname <your.virtual.machine.ip>
      IdentityFile ~/.ssh/<your_private_ssh_key>
  ```

Install `openssh-server` on the VM

On the host machine run:
  ```sh
  ssh-copy-id -i ~/.ssh/id_rsa.pub <recognizable_name>
  ```

This creates the .ssh directory and the authorized_keys file. You can now copy scripts using `scp` from your machine to the vm
  ```sh
  scp script <recognizable_name>:/home/username
  ```

Once you've created the `lfs` user, this process needs to be redone to create an authorized_keys file for the `lfs` user
  ```sh
  ssh-copy-id -i ~/.ssh/id_rsa.pub lfs@<recognizable_name>
  ```

To copy scripts to the lfs environment run:
  ```sh
  scp script lfs@<recognizable_name>:/mnt/lfs/sources
  ```

### General guidelines
For my installation Perl and XZ failed to download so I had to do them manually

The md5sum check is very important in order to make sure that you have downloaded all the required packages

Interesting answers on running scripts with cd:
  - https://unix.stackexchange.com/questions/38808/why-is-cd-not-a-program
  - https://stackoverflow.com/questions/14880777/how-can-i-cd-into-a-directory-using-a-script

The cleanup and backup section of Chapter 7 was skipped since I was using VM snapshots. (I also under-resourced my root partition so I didn't have 1GB lying around)

If at any point you leave the chroot environment or shut down your VM, run the below commands (this assumes that you're using a fresh terminal).
  ```sh
  sudo -i
  bash chroot_prep.sh
  bash create_essential_files_and_symlinks.sh
  ```

You'll get a message saying `/etc/mtab symlink already exists`, you can ignore this.

If you want to enforce the use of [strong passwords](https://www.linuxfromscratch.org/blfs/view/11.3/postlfs/cracklib.html). Note that this is not strictly necessary.

Be sure to download the package before entering the chroot environment otherwise you'll face difficulties trying to download and install the package. Remember to return to the link above to follow the instructions for installing.

Your VM image can be found at `/var/lib/libvirt/images/<vm-name>.qcow2`

Snapshots become quite memory intensive. I had to delete snapshots because I kept running out of space on my host machine.

I skipped the CD/DVD ROM section since I have no intention of using either. I just read through the section.

For the network configuration section, refer to the links below:
  - https://askubuntu.com/questions/947178/how-can-i-find-the-default-gateway-of-a-machine
  - https://askubuntu.com/questions/197628/how-do-i-find-my-network-ip-address-netmask-and-gateway-info

You could also refer to the same files in your host machine.

For a comparison between [systemd and sysvinit](https://itsfoss.com/systemd-init/)

Skipped configuration of the Linux Console so that the default kernel keymap is used. I'm expecting a U.S. keyboard with non-ASCII characters not being used.

I skipped the creation of a grub rescue image.

With all the steps done you should be able to log in to the LFS system as the root user.

Remember to keep track of the password set in Chapter 8 section 8.25.2 `Configuring Shadow` otherwise you'll have a system you cannot log into.

In the interests of saving space you can delete all downloaded tarballs leaving the file Linux-6.1.11 from `/mnt/lfs/sources`
