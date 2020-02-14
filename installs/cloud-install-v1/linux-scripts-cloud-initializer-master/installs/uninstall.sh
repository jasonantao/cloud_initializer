clear
cloudinit stop all
cloudinit clean all
bootstraps="/opt/CI/bin/scripts/bash/bootstraps"
apps="$bootstraps/apps"
pkg=$apps/CI
echo "uninstall_CI.sh ECECUTING: rm -rf $pkg"
rm -rf $pkg
echo "uninstall_CI.sh ECECUTING: rm -rf /var/www/html/cloudinitializer/"
rm -rf /var/www/html/cloudinitializer/
