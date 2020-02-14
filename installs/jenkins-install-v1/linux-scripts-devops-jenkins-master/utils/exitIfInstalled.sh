# EXIT IF INSTALLED
# VALIDATE THE INSTALLATION HOME DIRECTORY AND IF EXISTS, EXIT SCRIPT

jenkinsLock=$1
if [ -e $jenkinsLock ]
then
    echo installing Jenkins
else
    echo ERROR Lock $jenkinsLock found EXITING
    return
fi
