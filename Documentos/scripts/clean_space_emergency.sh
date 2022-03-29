#!/bin/bash
if [ -f '/tmp/clean_space_emergency.tmp' ];then
    exit
fi
if [ "$EUID" -ne 0 ]; then
    /usr/bin/echo "Please run as root";
    exit
fi
/usr/bin/touch /tmp/clean_space_emergency.tmp
/usr/bin/find /mnt/archlinux/btrbk_snapshots/HOME/* -prune -type d | while IFS= read -r d; do
    if [[ -d "$d" && "$d" != *"$(/usr/bin/btrfs subvol list / | /usr/bin/grep HOME | /usr/bin/awk '{print $9}' | /usr/bin/tail -1)"* ]]; then
        /usr/bin/btrfs sub del "$d"
    fi
done
/usr/bin/find /mnt/archlinux/btrbk_snapshots/ROOT/* -prune -type d | while IFS= read -r d; do
    if [[ -d "$d" && "$d" != *"$(/usr/bin/btrfs subvol list / | /usr/bin/grep ROOT | /usr/bin/awk '{print $9}' | /usr/bin/tail -1)"* ]]; then
        /usr/bin/btrfs sub del "$d"

    fi
done
/usr/bin/find /mnt/archlinux/refind_btrfs_rw_snapshots/* -prune -type d | while IFS= read -r d; do
    if [[ -d "$d" && "$d" != *"$(/usr/bin/btrfs subvol list / | /usr/bin/grep refind_btrfs_rw_snapshots | /usr/bin/awk '{print $9}' | /usr/bin/tail -1)"* ]]; then
        /usr/bin/btrfs sub del "$d"
    fi
done
if [ -z "$(/usr/bin/pgrep spotify)" ];then
    /usr/bin/rm -rf /home/lucas/.cache/spotify/
fi
if [ -z "$(/usr/bin/pgrep makepkg)" ];then
    /usr/bin/rm -rf /home/lucas/.ccache/*
    if [ -z "$(/usr/bin/pgrep yay)" ];then
        /usr/bin/rm -rf /home/lucas/.cache/yay/*
        /usr/bin/echo "s" | /usr/bin/yay -c \n
    fi
fi
if [ -z "$(/usr/bin/pgrep pacman)" ];then
    /usr/bin/rm -rf /mnt/archlinux/PKG/*
fi
if [ -z "$(/usr/bin/pgrep winetricks)" ];then
    /usr/bin/rm -rf /home/lucas/.cache/winetricks/*
fi
