#!/bin/bash
if test -f "/tmp/check_btrfs_health.sh.tmp"; then
    exit
fi
/usr/bin/touch "/tmp/check_btrfs_health.sh.tmp";
/usr/bin/sudo /usr/bin/btrfs device stats /
if [ $? -eq 1 ];then
    DISPLAY=:0 XDG_RUNTIME_DIR=/run/user/1000 /usr/bin/kdialog --error "$(/usr/bin/sudo /usr/bin/btrfs device stats /)" --title='Device IO error';
fi
/usr/bin/rm -f "/tmp/check_btrfs_health.sh.tmp";
