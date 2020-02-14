# Setup the required environment
. ./env/setEnv.sh

./installMySQL.sh |  tee installMySQL.log
./startMySQL.sh
