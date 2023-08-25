#!/bin/bash

echo "Starting installation of Ninja"

tar -xf ninja-1.11.1.tar.gz
cd ninja-1.11.1

# Ninja normally utilizes the greates number of processes in parallel.
# By default this is the number of cores on the system, plus two.
# This may overheat the CPU, or make the system run out of memory.
# Limit the number of parallel processes via an environment variable
export NINJAJOBS=4

# Make Ninja recognize the environment variable NINJAJOBS by running
# the stream editor
sed -i '/int Guess/a \
  int j = 0;\
  char* jobs = getenv( "NINJAJOBS" );\
  if ( jobs != NULL ) j = atoi( jobs );\
  if ( j > 0 ) return j;\
' src/ninja.cc

# Build Ninja
python3 configure.py --bootstrap

# Test the results
./ninja ninja_test
./ninja_test --gtest_filter=-SubprocessTest.SetWithLots

# Install
install -vm755 ninja /usr/bin/
install -vDm644 misc/bash-completion /usr/share/bash-completion/completions/ninja
install -vDm644 misc/zsh-completion /usr/share/zsh/site-functions/_ninja

echo "Finished installation of Ninja"

cd $LFS/sources
rm -rf ninja-1.11.1
