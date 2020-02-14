# EXIT IF INSTALLED
# VALIDATE THE INSTALLATION HOME DIRECTORY AND IF EXISTS, EXIT SCRIPT

wfHome=$1
if [ -d $wfHome ]; then
    echo WildFly Already installed EXITING
    return
fi
