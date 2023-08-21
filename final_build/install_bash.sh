#!/bin/bash

echo "Starting installation of Bash"

tar -xf bash-5.2.15.tar.gz
cd bash-5.2.15

./configure --prefix=/usr             \
            --without-bash-malloc     \
            --with-installed-readline \
            --docdir=/usr/share/doc/bash-5.2.15

make

# Ensure that the tester can write to the sources tree
chown -Rv tester .

# The test suite is designed to be run as a non-root user who owns the terminal
# connected to standard input.
# To satisfy this requirement, spawn a new pseudo terminal using Expect and run
# the tests as the tester user.
# The test suite uses diff to detect the difference between test script output and the expected output.
# Any output from diff (prefixed with < and >) indicates a test failure, unless
# there is a message saying the difference can be ignored.
# run-builtins test is known to fail on some host distros with a difference on the first
# line of the output.
su -s /usr/bin/expect tester << EOF
set timeout -1
spawn make tests
expect eof
lassign [wait] _ _ _ value
exit $value
EOF

make install

echo "Finished installation of Bash"

cd $LFS/sources
rm -rf bash-5.2.15

# Run the newly compiled bash program (replacing the one currently being executed)
# Run at the end because it terminates the currently running shell before cleanup is done.
exec /usr/bin/bash --login
