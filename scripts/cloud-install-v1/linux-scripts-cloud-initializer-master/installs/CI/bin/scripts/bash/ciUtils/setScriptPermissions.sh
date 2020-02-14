dir=$1
mode=$2
find $dir -name '*.sh' -exec chmod $mode {} \;
