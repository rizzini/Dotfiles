#!/bin/bash
if test -f "/tmp/check_btrfs_health.sh.tmp"; then
    exit
fi
/usr/bin/touch "/tmp/check_btrfs_health.sh.tmp";
for i in $(/usr/bin/sudo /usr/bin/btrfs device stats / | tr -d '/dev/sda2' | grep -o -E '[0-9]+'); do
    if [ "$i" != "0" ];then
        XDG_RUNTIME_DIR=/run/user/1000 DISPLAY=:0 /usr/bin/kdialog --error "$(/usr/bin/sudo /usr/bin/btrfs device stats /)" --title='Device IO error';
        break
    fi
done
/usr/bin/rm -f "/tmp/check_btrfs_health.sh.tmp";
