#!/bin/bash

echo "Starting installation of Iana-Etc-20230202"

tar -xf iana-etc-20230202.tar.gz
cd iana-etc-20230202

# For this package, we only need to copy the files into place
cp services protocols /etc

echo "Finished installation of Iana-Etc-20230202"

cd $LFS/sources
rm -rf iana-etc-20230202
