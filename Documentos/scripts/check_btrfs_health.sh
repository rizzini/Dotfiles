#!/bin/bash
if [ "$EUID" -ne 0 ]; then
    /usr/bin/echo "Please run as root";
    exit;
fi
if test -f "/tmp/check_btrfs_health.sh.tmp"; then
    exit;
fi
/usr/bin/touch "/tmp/check_btrfs_health.sh.tmp";
if ! /usr/bin/btrfs device stats -c /; then
    /usr/bin/btrfs device stats -c /mnt/backup | tee /home/lucas/check_btrfs_health.sh.ssd.log;
    /usr/bin/machinectl shell --uid=lucas .host /usr/bin/notify-send -u critical "Erro de E/S: /mnt/dados/ | Checar ~/check_btrfs_health.sh.ssd.log";
fi
if mount | grep -q '/mnt/dados'; then
    if [ ! "$(/usr/bin/btrfs device stats -c /mnt/dados)" ]; then
        /usr/bin/btrfs device stats -c /mnt/backup | tee /home/lucas/check_btrfs_health.sh.mnt.dados.log;
        /usr/bin/machinectl shell --uid=lucas .host /usr/bin/notify-send -u critical "Erro de E/S: /mnt/dados/ | Checar ~/check_btrfs_health.sh.mnt.dados.log";
    fi
fi
if mount | grep -q '/mnt/backup'; then
    if ! /usr/bin/btrfs device stats -c /mnt/backup; then
        /usr/bin/btrfs device stats -c /mnt/backup | tee /home/lucas/check_btrfs_health.sh.mnt.backup.log;
        /usr/bin/machinectl shell --uid=lucas .host /usr/bin/notify-send -u critical "Erro de E/S: /mnt/backup/ | Checar ~/check_btrfs_health.sh.mnt.backup.log";
    fi
fi
/usr/bin/rm -f "/tmp/check_btrfs_health.sh.tmp";
