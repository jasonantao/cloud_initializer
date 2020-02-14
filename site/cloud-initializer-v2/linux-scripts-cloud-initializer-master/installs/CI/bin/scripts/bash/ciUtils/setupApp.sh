#Sample install Call
#http://99.79.59.230:9090/ci/api/v1/install/wordpress?siteName=MyNewSite&port=9111&adminId=MyId&adminPWD=password&dbName=testval
CI_HOME="/opt/CI"
BOOTSTRAPS=$CI_HOME/bin/scripts/bash/bootstraps
LOGS=$CI_HOME/logs
APP_REPO=$1
APP_SUB_DIR=$(echo "$1" | sed 's/linux-scripts-//g' | sed 's/-/\//g') 
APP_BOOTSTRAP=$BOOTSTRAPS/$APP_SUB_DIR
APP_LOGS=$LOGS/$APP_SUB_DIR
shift
PARMS=$*
MODE=744
mkdir -p $APP_LOGS

echo "APP_REPO  = $APP_REPO" | tee $APP_LOGS/setup.log
echo "APP_SUB_DIR  = $APP_SUB_DIR" | tee $APP_LOGS/setup.log
echo "APP_BOOTSTRAP  = $APP_BOOTSTRAP" | tee -a $APP_LOGS/setup.log
echo "APP_LOGS  = $APP_LOGS" | tee -a $APP_LOGS/setup.log

echo "find $APP_BOOTSTRAP -name '*.sh' -exec chmod $MODE {} \;" | tee -a $APP_LOGS/setup.log

find $APP_BOOTSTRAP -name '*.sh' -exec chmod $MODE {} \;

cd $APP_BOOTSTRAP
echo EXECUTING: ./setup.sh $PARMS 2>&1| tee -a $APP_LOGS/setup.log
 ./setup.sh $PARMS 2>&1| tee -a $APP_LOGS/setup.log
