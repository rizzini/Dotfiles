#!/bin/bash
if [ "$EUID" -ne 0 ]; then
    /usr/bin/echo "Please run as root";
    exit;
fi
if [ "$1" == 'force' ];then
    /usr/bin/rm -f /tmp/clean_space_emergency.sh.lock;
fi
if test -f "/tmp/clean_space_emergency.sh.lock"; then
    exit 1
fi
/usr/bin/touch /tmp/clean_space_emergency.sh.lock
out_of_space=0;
{
if [[ "$(/usr/bin/df -B MB  /dev/sda2 --output=avail | /usr/bin/tail -1 | /usr/bin/tr -d 'MB')" -le 700 || "$1" == 'force' ]];then
    out_of_space=1;
    /usr/bin/find /mnt/archlinux/btrbk_snapshots/HOME/* -prune -type d | while IFS= read -r d; do
        if [[ -d "$d" && "$d" != *"$(/usr/bin/btrfs subvol list / | /usr/bin/grep HOME | /usr/bin/awk '{print $9}' | /usr/bin/tail -1)"* ]]; then
            /usr/bin/btrfs sub del "$d";
        fi
    done
    /usr/bin/find /mnt/archlinux/btrbk_snapshots/ROOT/* -prune -type d | while IFS= read -r d; do
        if [[ -d "$d" && "$d" != *"$(/usr/bin/btrfs subvol list / | /usr/bin/grep ROOT | /usr/bin/awk '{print $9}' | /usr/bin/tail -1)"* ]]; then
            /usr/bin/btrfs sub del "$d";
        fi
    done
    /usr/bin/find /mnt/archlinux/refind_btrfs_rw_snapshots/* -prune -type d | while IFS= read -r d; do
        if [[ -d "$d" && "$d" != *"$(/usr/bin/btrfs subvol list / | /usr/bin/grep refind_btrfs_rw_snapshots | /usr/bin/awk '{print $9}' | /usr/bin/tail -1)"* ]]; then
            /usr/bin/btrfs sub del "$d";
        fi
    done
    if [ -z "$(/usr/bin/pgrep spotify)" ];then
        /usr/bin/rm -rf /home/lucas/.cache/spotify/;
    fi
    if [ -z "$(/usr/bin/pgrep makepkg)" ];then
        /usr/bin/rm -rf /home/lucas/.ccache/*;
        if [ -z "$(/usr/bin/pgrep yay)" ];then
            /usr/bin/yay -Scc --noconfirm;
        fi
    fi
    if [ -z "$(/usr/bin/pgrep pacman)" ];then
        /usr/bin/rm -rf /mnt/archlinux/PKG/*;
    fi
    if [ -z "$(/usr/bin/pgrep winetricks)" ];then
        /usr/bin/rm -rf /home/lucas/.cache/winetricks/*;
    fi
    fi
    if [[ "$(/usr/bin/df -B MB  /dev/sdb2 --output=avail | /usr/bin/tail -1 | /usr/bin/tr -d 'MB')" -le 700 || "$1" == 'force' ]];then
    out_of_space=1;
    /usr/bin/killall -9 btrbk_ btrbk;
    /usr/bin/find /mnt/backup/ROOT/* -prune -type d | while IFS= read -r d; do
        if [[ -d "$d" && "$d" != *"$(/usr/bin/btrfs subvol list /mnt/backup/ROOT/ | /usr/bin/grep ROOT | /usr/bin/awk '{print $9}' | /usr/bin/tail -1)"* ]]; then
            /usr/bin/btrfs sub del "$d";
        fi
    done
    /usr/bin/find /mnt/backup/HOME/* -prune -type d | while IFS= read -r d; do
        if [[ -d "$d" && "$d" != *"$(/usr/bin/btrfs subvol list /mnt/backup/HOME/ | /usr/bin/grep HOME | /usr/bin/awk '{print $9}' | /usr/bin/tail -1)"* ]]; then
            /usr/bin/btrfs sub del "$d";
        fi
    done
fi
} &> /tmp/clean_space_emergency.sh.log
if [[ $out_of_space = 1 && "$1" != 'force' ]];then
    /usr/bin/machinectl shell --uid=lucas .host /usr/bin/notify-send -u critical "Script clean_space_emergency.sh executado. Checar logs em /tmp/clean_space_emergency.sh.log."
    exit 0;
fi
