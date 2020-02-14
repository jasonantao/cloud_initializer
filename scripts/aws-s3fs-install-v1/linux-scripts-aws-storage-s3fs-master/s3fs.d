#!/bin/bash
# chkconfig: 2345 20 80
# description: S3FS Auto service mount script
# processname: s3fs
# Author     : Robin Melanson (Contractor)
# Contact    : robin.e.melanson@gmail.com

parms="$1 $2 $3 $4"
#Trim parms leading and trailing white spaces
parms=$(echo -e $parms | sed 's/^[ \t]*//;s/[ \t]*$//')
echo "Executing service s3fs $parms"

mode=$1
s3fsMounts=/etc/init.d/s3fsMounts

help ()
{
   clear;
   echo "=========================  S3FS HELP MENU ============================"
   echo "# description: S3FS Auto service mount script"
   echo "# processname: s3fs"
   echo "# Author     : Robin Melanson (Contractor)"
   echo "# Contact    : robin.e.melanson@gmail.com"
   echo "======================================================================"
   echo "Usage(1): service s3fs start <mountPoint(Optional)>"
   echo "          if optional <mountPoint> is specified"
   echo "             and it exists in file $s3fsMounts,"
   echo "             it will be started(mounted)"
   echo "          if optional <mountPoint> is not specified,"
   echo "             all mounts in file $s3fsMounts will be"
   echo "             started(mounted)"
   echo "Usage(2): service s3fs stop <mountPoint(Optional)>"
   echo "          if optional <mountPoint> is specified,"
   echo "             it will be stopped(unmounted) and"
   echo "             the mount point will be deleated"
   echo "          if optional <mountPoint> is not specified,"
   echo "             all mounts in file $s3fsMounts will be"
   echo "             stopped(unmounted) and all mount points"
   echo "             specified in $s3fsMounts will be deleated"
   echo "Usage(3): service s3fs mount <s3Bucket> <mountPoint> <clientOwner(Optional)>"
   echo "             Mount <s3Bucket> to <mountPoint>(directory),"
   echo "             add the service mount to automount file $s3fsMounts"
   echo "             and mount the <s3Bucket> to the <mountPoint>."
   echo "             If optional <clientOwner> is specified, recursivly change"
   echo "             permission of all files in the new mount to the specified"
   echo "             <clientOwner>"
   echo "Usage(4): service s3fs umount <mountPoint>"
   echo "             Stop(unmount) <mountPoint> and removed from"
   echo "             automount file $s3fsMounts"
}

usage ()
{
   clear;
   echo $"Usage(1): service s3fs start" 1>&2
   echo $"Usage(2): service s3fs stop <mountPoint(Optional)>" 1>&2
   echo $"Usage(3): service s3fs mount <s3Bucket> <mountPoint> <clientOwner(Optional)>" 1>&2
   echo $"Usage(4): service s3fs umount <mountPoint>" 1>&2
   echo $"Usage(4): service s3fs help" 1>&2
   RETVAL=2
}

start(){
   if [ -f $s3fsMounts ]
   then
      mountPoint=$1
      if [ ! -z $mountPoint ]
      then
         echo "mounting $mountPoint"
         $(grep "$mountPoint$" $s3fsMounts)
      else
         . $s3fsMounts
      fi
   else
       echo "S3FS file $s3fsMounts does not exist. Nothing to mount" 1>&2
   fi
}

stop(){
   if [ -f $s3fsMounts ]
   then
      mountPoint=$1
      if [ ! -z $mountPoint ]
      then
         echo "$mountPoint unmounted"
         umount $mountPoint
         rmdir $mountPoint
      else
         echo "Unmount all mounts"
         while IFS= read line
         do
         # display $line or do somthing with $line
             mountPoint=$(echo $line | cut -d' ' -f5)
             stop $mountPoint
             #umountCmd=$(echo service s3fs umount $mountPoint)
             #$umountCmd
         done < "$s3fsMounts"
      fi
   else
       echo "S3FS file $s3fsMounts does not exist. Nothing to unmountp" 1>&2
   fi
}

mount() {
   s3Bucket=$1
   mountPoint=$2
   client=$3
   if [ ! -z $4 ]
   then
      echo setting s3fsMounts=$4
      s3fsMounts=$4
   fi
   newMount="/usr/local/bin/s3fs $s3Bucket $mountPoint -o passwd_file=/etc/passwd-s3fs -o allow_other";
   serviceMount="service s3fs mount $s3Bucket $mountPoint $user"
   # Trim leading and trailing white spaces from variable serviceMount
   serviceMount=$(echo -e $serviceMount | sed 's/^[ \t]*//;s/[ \t]*$//')

   #Check if mount point does not exist and create it if it does not.
   if [ ! -d $mountPoint ]
   then
      echo "Creating Mount Point $mountPoint"
      mkdir $mountPoint
      chmod 777 $mountPoint
   fi

   if [ -f $s3fsMounts ]
   then
       if ! grep -xq "$serviceMount" $s3fsMounts
       then
           echo "Appending Mount Command <$serviceMount> to existing file <$s3fsMounts>"
           echo $serviceMount | tee -a $s3fsMounts
       fi
   else
       echo "Adding Mount Command <$serviceMount> to file <$s3fsMounts>"
       echo $serviceMount | tee $s3fsMounts
   fi

   $newMount
}

unmount() {
   mountPoint=$1
   if [ ! -z $2 ]
   then
     echo setting s3fsMounts=$2
      s3fsMounts=$2
   fi

   if [ -d $mountPoint ]
   then
#      echo EXECUTING  sed -i "/${mountPoint//\//\\/}/d" $s3fsMounts
      stop $mountPoint
      echo "Delete from Automount file $s3fsMounts"
      sed -i "/${mountPoint//\//\\/}/d" $s3fsMounts
      
   else
      echo "Mount Point $1 not found" 1>&2
   fi
}

case "$mode" in
 'start')
   start $2
   ;;
 'stop')
   stop $2
   ;;
 'mount')
   mount $2 $3 $4 $5
   ;;
 'umount')
   unmount $2 $3
   ;;
 'help')
   help
   ;;
 *) usage
   ;;
esac

