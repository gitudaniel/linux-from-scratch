#!/bin/bash

# Since the running of tests for this package takes a long time
# pipe the standard output to a separate file and confirm results
# afterwards
# `bash install_gcc.sh | tee /tmp/install_gcc.txt
# cat can be used to display the contents of the file

echo "Starting installation of GCC"

tar -xf gcc-12.2.0.tar.xz
cd gcc-12.2.0

# Change the directory name for 64-bit libraries to "lib"
# I'm building on x86_64
case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig gcc/config/i386/t-linux64
  ;;
esac

mkdir -v build
cd build

../configure --prefix=/usr            \
             LD=ld                    \
             --enable-languages=c,c++ \
             --enable-default-pie     \
             --enable-default-ssp     \
             --disable-multilib       \
             --disable-bootstrap      \
             --with-system-zlib

# Compile
make

# One of the tests in the GCC test suite is known to exhaust the default stack.
# Increase the stack size prior to running the tests
ulimit -s 32768

# Test the results as a non-privileged user, but do not stop at errors
chown -Rv tester .
su tester -c "PATH=$PATH make -k check"

# Extract a summary of the test suite results and compare with those located at
# https://www.linuxfromscratch.org/lfs/build-logs/11.3/
../contrib/test_summary

# Install
make install

# The GCC build directory is currently owned by tester, and the ownership of the
# installed header directory (and contents) is incorrect.
# Change ownership to root user and group.
chown -v -R root:root \
    /usr/lib/gcc/$(gcc -dumpmachine)/12.2.0/include{,-fixed}

# Create a symlink required by the FHS for "historical" reasons
ln -svr /usr/bin/cpp /usr/lib

# Add a compatibility symlink to enable building programs with
# Link Time Optimization (LTO)
ln -sfv ../../libexec/gcc/$(gcc -dumpmachine)/12.2.0/liblto_plugin.so \
        /usr/lib/bfd-plugins/

# Perform sanity checks to ensure that compiling and linking will work as expected.
# There should be no errors and the output of the last command will be
## [Requesting program interpreter: /lib64/ld-linux-x86-64.so.2]
echo 'int main(){}' > dummy.c
cc dummy.c -v -Wl,--verbose &> dummy.log
readelf -l a.out | grep ': /lib'

# Ensure that we're set up to use the correct start files.
# The output of the command below should be
## /usr/lib/gcc/x86_64-pc-linux-gnu/12.2.0/../../../../lib/Scrt1.o succeeded
## /usr/lib/gcc/x86_64-pc-linux-gnu/12.2.0/../../../../lib/crti.o succeeded
## /usr/lib/gcc/x86_64-pc-linux-gnu/12.2.0/../../../../lib/crtn.o succeeded
grep -E -o '/usr/lib.*/S?crt[1in].*succeeded' dummy.log

# Verify that the compiler is searching for the correct header files
# The output returned can be seen below
## #include <...> search starts here:
##  /usr/lib/gcc/x86_64-pc-linux-gnu/12.2.0/include
##  /usr/local/include
##  /usr/lib/gcc/x86_64-pc-linux-gnu/12.2.0/include-fixed
##  /usr/include
grep -B4 '^ /usr/include' dummy.log

# Verify that the new linker is being used with the correct search paths
# The output should be:
## SEARCH_DIR("/usr/x86_64-pc-linux-gnu/lib64")
## SEARCH_DIR("/usr/local/lib64")
## SEARCH_DIR("/lib64")
## SEARCH_DIR("/usr/lib64")
## SEARCH_DIR("/usr/x86_64-pc-linux-gnu/lib")
## SEARCH_DIR("/usr/local/lib")
## SEARCH_DIR("/lib")
## SEARCH_DIR("/usr/lib");
grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g'

# Ensure we're using the correct libc
# Output:
## attempt to open /usr/lib/libc.so.6 succeeded
grep "/lib.*/libc.so.6 " dummy.log

# Ensure GCC is using the correct dynamic linker
# Output:
## found ld-linux-x86-64.so.2 at /usr/lib/ld-linux-x86-64.so.2
# If the output does not appear as shown above or does not appear at all,
# investigate and retrace the steps to find out where the problem is and
# correct it.
# Any issues should be resolved before continuing with the process
grep found dummy.log

# Move a misplaced file
mkdir -pv /usr/share/gdb/auto-load/usr/lib
mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib

# Since I was not actively monitoring the installation of GCC because of the time taken
# I removed the test files manually after verifying that everything installed correctly.
# The untarred GCC directory was also removed manually after verification.

echo "Finished installation of GCC"

cd $LFS/sources
