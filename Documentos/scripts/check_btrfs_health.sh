#!/bin/bash
if test -f "/tmp/check_btrfs_health.sh.tmp"; then
    exit;
fi
/usr/bin/touch "/tmp/check_btrfs_health.sh.tmp";
/usr/bin/sudo /usr/bin/btrfs device stats -c /;
if [ $? != 0 ];then
    DISPLAY=:0 XDG_RUNTIME_DIR=/run/user/1000 /usr/bin/kdialog --error "$(/usr/bin/sudo /usr/bin/btrfs device stats /)" --title='Arch: Device IO error';
fi
if [ -n "$(mount | grep '/mnt/dados')" ];then
    /usr/bin/sudo /usr/bin/btrfs device stats -c /mnt/dados/;
    if [ $? != 0 ];then
        DISPLAY=:0 XDG_RUNTIME_DIR=/run/user/1000 /usr/bin/kdialog --error "$(/usr/bin/sudo /usr/bin/btrfs device stats /)" --title='Dados: Device IO error';
    fi
fi
if [ -n "$(mount | grep '/mnt/backup')" ];then
    /usr/bin/sudo /usr/bin/btrfs device stats -c /mnt/backup/;
    if [ $? != 0 ];then
        DISPLAY=:0 XDG_RUNTIME_DIR=/run/user/1000 /usr/bin/kdialog --error "$(/usr/bin/sudo /usr/bin/btrfs device stats /)" --title='Backup: Device IO error';
    fi
fi
/usr/bin/rm -f "/tmp/check_btrfs_health.sh.tmp";
