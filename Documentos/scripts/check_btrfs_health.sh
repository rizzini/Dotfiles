#!/bin/bash
if test -f "/tmp/check_btrfs_health.sh.tmp"; then
    exit;
fi
/usr/bin/touch "/tmp/check_btrfs_health.sh.tmp";
if ! /usr/bin/sudo /usr/bin/btrfs device stats -c /
then
    DISPLAY=:0 XDG_RUNTIME_DIR=/run/user/1000 /usr/bin/kdialog --error "Arch SSD:\n$(/usr/bin/sudo /usr/bin/btrfs device stats /)" --title='Device IO error' &
fi
if mount | grep -q '/mnt/dados'
then
    if [ ! "$(/usr/bin/sudo /usr/bin/btrfs device stats -c /mnt/dados)" ];then
        DISPLAY=:0 XDG_RUNTIME_DIR=/run/user/1000 /usr/bin/kdialog --error "Dados:\n$(/usr/bin/sudo /usr/bin/btrfs device stats /)" --title='Device IO error' &
    fi
fi
if mount | grep -q '/mnt/backup'
then
    if ! /usr/bin/sudo /usr/bin/btrfs device stats -c /mnt/backup
    then
        DISPLAY=:0 XDG_RUNTIME_DIR=/run/user/1000 /usr/bin/kdialog --error "Backup:\n$(/usr/bin/sudo /usr/bin/btrfs device stats /)" --title='Device IO error' &
    fi
fi
/usr/bin/rm -f "/tmp/check_btrfs_health.sh.tmp";
