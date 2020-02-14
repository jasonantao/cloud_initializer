App=$1
if [ -z $1 ]; then
   echo "ERROR APP Not Specified"
else
   FILE=uninstall_$1.sh
   if [ -f "$FILE" ]; then
      echo "EXECUTING . ./$FILE"
      . ./$FILE;
   else 
      echo ""ERROR $FILE does not exist"
   fi
fi
