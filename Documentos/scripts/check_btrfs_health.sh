#!/bin/bash
if test -f "/tmp/check_btrfs_health.sh.tmp"; then
    exit 1
fi
/usr/bin/touch "/tmp/check_btrfs_health.sh.tmp";
error=0
for i in $(/usr/bin/sudo /usr/bin/btrfs device stats /); do
    if [[ "$i" != *"/dev/sda2"* && "$i" != 0 ]];then
        error=1;
    fi
done
if [ $error = 1 ];then
    XDG_RUNTIME_DIR=/run/user/1000 DISPLAY=:0 /usr/bin/kdialog --error "$(/usr/bin/sudo /usr/bin/btrfs device stats /)" --title='Device IO error';
fi
/usr/bin/rm -f "/tmp/check_btrfs_health.sh.tmp";
