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
keyPvtFile=./keyLocker/$2

HOME_DIR=$(eval echo ~$USER)

echo "Adding User $USER keyPvtFile $keyPvtFile"
echo EXECUTING COMMAND mkdir $HOME_DIR/.ssh
mkdir $HOME_DIR/.ssh
echo EXECUTING COMMAND cp ./keyLocker/$value $HOME_DIR/.ssh/authorized_keys
cp $keyPvtFile $HOME_DIR/.ssh/authorized_keys
echo EXECUTING COMMAND chown -R $USER:$USER $HOME_DIR/.ssh
chown -R $USER:$USER $HOME_DIR/.ssh; 
echo chmod 700 $HOME_DIR/.ssh
chmod 700 $HOME_DIR/.ssh
echo EXECUTING COMMAND chmod 600 $HOME_DIR/.ssh/authorized_keys
chmod 600 $HOME_DIR/.ssh/authorized_keys
