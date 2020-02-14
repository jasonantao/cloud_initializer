#!/bin/bash
# chkconfig: 2345 20 80
# description: appServices ~ Start an Application as a Services
# process Name: start
# ciDir=/opt/CI
# servicesDir=$ciDir/services
# pidDir=$servicesDir/ids
# logDir=$servicesDir/logs
# Author: Robin Melanson (Contractor)
# Contact: robin.e.melanson@gmail.com

args="$*"
noArgs=$#
ciDir=/opt/CI
servicesDir=$ciDir/services
pidDir=$servicesDir/ids
logDir=$servicesDir/logs
testScripts=$servicesDir/test/scripts/*

#serviceType=null;

isNumber() {
   parms=$1
   nums='^[0-9]+$'
   if [[ $parms =~ $nums ]]; then
      return 0;
   else
      return 1;
   fi
}

dirExists() {
   dir = $1;
   if [ -d $dir ]; then
      // 0 is true in shell scripting
      return 0; 
   else
      return 1;
   fi
}

dirNotEmpty() {
   dir = $1;
   if [ dirExists $dir ]; then
      count=$(ls -1q $dir | wc -l);
      echo Count = $count:1
      if [ "$count" -gt "0" ]; then
          return 0;
      fi
   fi
   return 1
}

selectAll() {
  parms=$1
  if [ "${parms^^}" == "ALL" ]; then
     return 0;
  else
     return 1;
  fi
}

isNull() {
   if [ -z $1 ]; then
      return 0;
   else
      return 1;
   fi
}

getDirFilesOnly(){
   echo $(ls -p $1 | grep -v /)
}

getRegusteredPIDs(){
   getDirFilesOnly $pidDir
}

fileExists() {
   if [ -f "$1" ]; then
     return 0;
   else 
      return 1;
   fi
}

pidRegistered() {
   pid=$1
   if fileExists $pidDir/$pid; then
      return 0;
   else 
      return 1;
   fi
}

getFileContents() {
   absPID=$1
   if fileExists $absPID; then
       process=$(cat $absPID)
   else
       process="$absPID Not Registered"
    fi
    echo $process
}

getPIDContents() {
   pid=$1
   echo $(getFileContents $pidDir/$pid);
}


runningPID() {
   pid=$1
   systemPIDs=$(ps -A -o pid)
   #echo "CHECKING pids $systemPIDs"
   if [[ $systemPIDs == *"$pid"* ]]; then
      return 0;
   else
      return 1;
   fi
}

setProcessType() {
   if isNull $1; then
       serviceType="NULL"
#       echo "is NULL";
   elif isNumber $1; then
       serviceType="PID";
#       echo "is PID";
   elif selectAll $1; then
       serviceType="ALL";
#       echo "Process ALL";
   else
       serviceType="JOB";
#       echo "Process job";
   fi
}

setLogFile(){
   logfile=$logDir/$(date +"%y-%m-%d").log
}

echoLog() {
   setLogFile;
   parms="$*";
   tm=$(date +"%H:%M:%S>");
   tmParms=$tm$parms;
   echo $tmParms | tee -a $logfile;
}

log() {
   echo $1 >> $logfile;
}

debugTest() {
   echoLog $1;
}

usage() {
   if [ ! -z $1 ]; then
     echoLog $1;
   fi
   echo "=============================USAGE================================";
   echo $"Usage: $0 {start|stop|restart|clean|status|help}";
}

about() {
   clear;
   echoLog "======================= ABOUT APPS SERVICES ==========================";
   echo "# description: $prog ~ Add Applications as a Services";
   echo "# processname: $prog";
   echo "# Author     : Robin Melanson (Contractor)";
   echo "# Contact    : robin.e.melanson@gmail.com";
   usage;
}

help () {
   about
   echoLog;
   echo "====================  APPS SERVICES HELP MENU ========================"
   echo "Usage(1): service $prog start <cmd (Optional)>"
   echo "             The application as a services will be started"
   echo "Usage(2): service $prog stop"
   echo "             The $prog service will be stopped"
   echo "Usage(3): service $prog restart"
   echo "             The $prog services will be restarted"
   echo "             This is accomplished through starting"
   echo "             and stopping the appService app"
   echo "Usage(4): service $prog * <prog Name>"
   echo "             Prints out the appService usage syntax"
   echo "======================================================================"
}

test() {
   testDir="$*"
   for f in $testDir
   do
      echoLog  "Starting Test File $f"
      script=$(cat $f)
      start "$script"
   done
}

startJOB()
{
    job=$*
    $job &
    pid=$!;
    echoLog "start($1) EXECUTING: echo $job &";
    echo $job > $pidDir/$pid;
}

processPIDs() {
  args=$*;
  serviceType="${1^^}"
  # Concatinate Args
  servicePids=$(echo $args | cut -d " " -f2-)
  #Remove Functions Call Name
  servicePids=${servicePids//$1/}
  debugTest "processPIDs() $serviceType $servicePids";
  for pid in $servicePids
  do
     pid="$(basename -- $pid)"
     absPID=$pidDir/$pid;
     pidContents=$(getPIDContents $pid);
     case "$serviceType" in
           CLEAN)
                 if runningPID $pid; then
                    echoLog  "Running PID $pid $pidContents";
                 else
                    echoLog  "Removing Stopped Registered PID $pid $pidContents";
                    rm $absPID;
                 fi
                 ;;
           DELETE)
                 if pidRegistered $pid; then
                    echoLog "De-registering PID $pid $pidContents";
                    rm $absPID;
                 else
                    echoLog "Not Registered PID $pid";
                 fi
                 ;;
           START)
                 if runningPID $pid; then
                    echoLog "Already running PID $pid $pidContents";
                 else
                    job=$(cat $absPID);
                    startJOB $job;
                    echoLog "Starting PID $pid $job";
                    rm $absPID;
                 fi
                 ;;
          STOP)
                 if runningPID $pid; then
                    echoLog "Killing Process $pid : $(getPIDContents $pid)";
                    kill -9 "$pid"
                 else
                    echoLog "Process $pid Running: $(getPIDContents $pid)";
                 fi
                 ;;
          RESTART)
                 if pidRegistered $pid; then
                    if runningPID $pid; then
                       kill -9 "$pid"
                    fi
                    job=$(cat $absPID);
                    startJOB $job;
                    rm $absPID;
                    echoLog "Re-Started PID $pid $job";
                 else
                    echoLog "Running Process $pid Not Registered"
                 fi
                 ;;
          STATUS)
                 if runningPID $pid; then
                    echoLog "Running Process $pid Found: $(getPIDContents $pid)";
                 else
                    echoLog "Process $pid *NOT* Running: $(getPIDContents $pid)";
                 fi
                 ;;
          *) usage
             exit 1
             ;;
         esac
  done
}

### main logic ###
# Set mode to Upercase $1 
mode="${1^^}"
echoLog "<======== Executing service apps $args ========>"
# Concatinate Args
serviceParms=$(echo $args | cut -d " " -f2-)
#Remove Functions Call Name
serviceParms=${serviceParms//$1/}
# Get the Service Process Type
setProcessType $serviceParms;

if [ "$serviceType" == "ALL" ]; then
   serviceParms="$(getRegusteredPIDs)";
fi

case "$serviceType" in
    ALL|PID)
         case "$mode" in
            CLEAN|DELETE|RESTART|RELOAD|START|STATUS|STOP)
              processPIDs $mode $serviceParms
            ;;
            TEST)
              usage "Undefined Parameters $testScripts";
            ;;
           *) usage
              exit 1
           ;;
       esac
   ;;
   SETMENU)
      echo EXECUTING SETMENU for PARMS $*
   ;;
   NULL)
       case "$mode" in
            HELP|USAGE|ABOUT|?)
               help
            ;;
            STATUS)
               processPIDs STATUS $(getRegusteredPIDs);
            ;;
            TEST)
               test $testScripts;
            ;;
            *) usage
              exit 1
       esac
   ;;
   JOB)
       echoLog "Starting Services $procs"
       startJOB $serviceParms;
    ;;
esac

exit 0
