#!/bin/bash
fuseDir=./s3fs-fuse

# Download the s3fs fuse libs
if [ ! -d "$fuseDir" ]
then
   git clone https://github.com/s3fs-fuse/s3fs-fuse.git
fi

# Build, Configure snd install s3fs Fuse
cd $fuseDir
./autogen.sh
./configure
make
make install
