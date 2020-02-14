numArgs=$#
if [ "$numArgs" -lt 2 ]
then
    if [ "$numArgs" -lt 1 ]
    then
        echo "USER Not specified ~ Illegal number of parameters $numArgs"
    fi
    echo "SSH_KEY Not specified ~ Illegal number of parameters $numArgs"
    echo "Usage: addSSH_Security.sh USER_NAME SSH PUBLIC KEY"
    exit -1
fi

USER=$1
sshDevKey=$2

if grep -q $USER "/etc/passwd"; then
   echo User $USER exists: \*\*\* Not adding \*\*\*
   exit
fi

echo ########################################################################################
echo "====== ADDING NEW USER $USER ======"
 
echo PROCESSING USERFILE $USER_FILE

PASSWORD="-p $(openssl passwd -1 "ineedtolearn")"

SHELL="-s /bin/bash"

echo USER = $USER
echo PASSWORD = $PASSWORD
echo SHELL = $SHELL
ADD_NEW_USER="useradd $USER $PASSWORD $SHELL"

echo EXECUTING $ADD_NEW_USER
$ADD_NEW_USER

echo ----------------------------------------------------------------------------------------
echo "====== Extracting $USER Home Directiry ======"

echo EXECUTING "HOME_DIR=$(eval echo ~$USER)"
HOME_DIR=$(eval echo ~$USER)
echo HOME_DIR = $HOME_DIR

echo ----------------------------------------------------------------------------------------
echo "====== ADDING NEW USER $USER SSH SECURITY ======"

ADD_SSH_SECURITY=". ./installs/addSSH_Security.sh $USER $sshDevKey"

echo EXECUTING $ADD_SSH_SECURITY
$ADD_SSH_SECURITY


echo ----------------------------------------------------------------------------------------
echo "====== ADDING NEW USER $USER SUDO ACCESS ======"

ADD_SUDO_ACCESS=". ./installs/addSudoAccess.sh"

echo EXECUTING $ADD_SUDO_ACCESS
$ADD_SUDO_ACCESS
echo ########################################################################################
