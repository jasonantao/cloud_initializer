#!/bin/bash
s3fsInstDir=$PWD

# add the s3fs access credentials built from IAM with s3 full access rights
pvtKey=$1
pubKey=$2
if [ -z $pvtKey ]
then
   pvtKey=AKIAILM6IJE5QG26I6CQ
fi

if [ -z $pubKey ]
then
   pubKey=kQhOnXfkdSzoAVYoMPjE7lS+Fa7LrQeqkbcUr0b4
fi

echo pvtKey=$pvtKey
echo pubKey=$pubKey
echo $pvtKey:$pubKey > /etc/passwd-s3fs
chmod 600 /etc/passwd-s3fs

