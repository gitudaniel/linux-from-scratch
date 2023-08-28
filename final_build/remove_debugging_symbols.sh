#!/bin/bash

echo "Starting strip of debug symbols from binaries and libraries and clean up of unneeded files"

# A large number of files will be flagged as errors because their file format is
# not recognized. These warnings can safely be ignored.
# They indicate that those files are scripts, not binaries
save_usrlib="$(cd /usr/lib; ls ld-linux*[^g])
             libc.so.6
             libthread_db.so.1
             libquadmath.so.0.0.0
             libstdc++.so.6.0.30
             libitm.so.1.0.0
             libatomic.so.1.2.0"

cd /usr/lib

for LIB in $save_usrlib; do
    objcopy --only-keep-debug $LIB $LIB.dbg
    cp $LIB /tmp/$LIB
    strip --strip-unneeded /tmp/$LIB
    objcopy --add-gnu-debuglink=$LIB.dbg /tmp/$LIB
    install -vm755 /tmp/$LIB /usr/lib
    rm /tmp/$LIB
done

online_usrbin="bash find strip"
online_usrlib="libbfd-2.40.so
               libsframe.so.0.0.0
               libhistory.so.8.2
               libncursesw.so.6.4
               libm.so.6
               libreadline.so.8.2
               libz.so.1.2.13
               $(cd /usr/lib; find libnss*.so* -type f)"

for BIN in $online_usrbin; do
    cp /usr/bin/$BIN /tmp/$BIN
    strip --strip-unneeded /tmp/$BIN
    install -vm755 /tmp/$BIN /usr/bin
    rm /tmp/$BIN
done

for LIB in $online_usrlib; do
    cp /usr/lib/$LIB /tmp/$LIB
    strip --strip-unneeded /tmp/$LIB
    install -vm755 /tmp/$LIB /usr/lib
    rm /tmp/$LIB
done

for i in $(find /usr/lib -type f -name \*.so* ! -name \*dbg) \
         $(find /usr/lib -type f -name \*.a)                 \
         $(find /usr/{bin,sbin,libexec} -type f); do
    case "$online_usrbin $online_usrlib $save_usrlib" in
        *$(basename $i)* )
            ;;
        * ) strip --strip-unneeded $i
            ;;
    esac
done

unset BIN LIB save_usrlib online_usrbin online_usrlib

# Clean up some extra files left over from running tests
rm -rf /tmp/*

# There are also several files in the /usr/lib and /usr/libexec directories
# with a file name extension of .la.
# These are "libtool archive" files.
# On a modern Linux system, the libtool .la files are only useful for libltdl.
# No binaries of LFS are expected to be loaded by libltdl, and it's known that
# some .la files can break BLFS package builds. Remove those files.
find /usr/lib /usr/libexec -name \*.la -delete

# The compiler built in Chapters 6 and 7 is still partially installed and not
# needed anymore. Remove it with the command below
find /usr -depth -name $(uname -m)-lfs-linux-gnu\* | xargs rm -rf

# Remove the temporary 'tester' user account created at the beginning of Chapter 7.
userdel -r tester

echo "Finished strip of debug symbols from binaries and libraries and clean up of unneeded files"

cd $LFS/sources
