scriptType=$1
pkg=$2
bootStrapDir="/opt/CI/bin/scripts/bash/bootstraps"
pkgDir="$scriptType/$pkg"

echo "reinstall.sh EXECUTING: . ../uninstalls/uninstall_$pkg.sh"
 . ../uninstalls/uninstall_$pkg.sh
 
echo "reinstall.sh EXECUTING: . ../uninstalls/clone_$pkg.sh"
 . ../uninstalls/clone.sh $scriptType $pkg

echo "reinstall.sh EXECUTING: . /opt/CI/bin/scripts/bash/ciUtils/setupApp.sh $pkgDir"
. /opt/CI/bin/scripts/bash/ciUtils/setupApp.sh $pkgDir
