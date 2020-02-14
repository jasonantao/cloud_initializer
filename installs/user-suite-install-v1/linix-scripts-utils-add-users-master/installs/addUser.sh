if [ "$#" -lt 1 ]
then
    echo "USER Not specified ~ Illegal number of parameters $#"
    return
fi

USER=$1

if grep -q $USER "/etc/passwd"; then
   echo User $USER exists: \*\*\* Not adding \*\*\*
   return
fi

. ./env/setEnv.sh

echo "Adding User $USER"
 
USER_FILE=./users/$USER

echo PROCESSING USERFILE $USER_FILE

while read key value
   do
      echo processing User $USER property key = $key with value $value

      case "$key" in
        password)
              PASSWORD="-p $(openssl passwd -1 $value)"
              ;;
        home)
              HOME_DIR=$value
              ;;
        sshPubKey)
              SSH_DEV_KEY=$value
              ;;
        sudo)
              SUDO_ACCESS=$value
              ;;
        shell)
              SHELL="-s /bin/$value"
              ;;
       *) echo Unknown property key = $key with value $value
             exit 1
             ;;
       esac

done < "$USER_FILE"

ADD_NEW_USER="useradd $USER $PASSWORD $HOME_DIR $SHELL"
echo EXECUTING $ADD_NEW_USER
$ADD_NEW_USER

echo ----------------------------------------------------------------------------------------
echo "====== Extracting $USER Home Directiry ======"

echo EXECUTING "HOME_DIR=$(eval echo ~$USER)"
HOME_DIR=$(eval echo ~$USER)
echo HOME_DIR = $HOME_DIR

# SLEEP FOR 1 SECOND GIVE TIME FOR USER TO BE CREATED BEFORE PROCEEDING
sleep 1

echo ----------------------------------------------------------------------------------------
echo "====== ADDING NEW USER $USER SSH SECURITY ======"

ADD_SSH_SECURITY=". ./installs/addSSH_Security.sh $USER $SSH_DEV_KEY"
echo EXECUTING $ADD_SSH_SECURITY
$ADD_SSH_SECURITY

ADD_SUDO_ACCESS=". ./installs/addSudoAccess.sh $USER"
echo EXECUTING $ADD_SUDO_ACCESS
$ADD_SUDO_ACCESS 
echo ########################################################################################
