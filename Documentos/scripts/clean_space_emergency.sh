#!/bin/bash
if [ -f '/tmp/clean_space_emergency.tmp' ];then
    exit
fi
if [ "$EUID" -ne 0 ]; then
    /usr/bin/echo "Please run as root";
    exit
fi
touch /tmp/clean_space_emergency.tmp
find /mnt/archlinux/btrbk_snapshots/HOME/* -prune -type d | while IFS= read -r d; do
    if [[ -d "$d" && "$d" != *"$(btrfs subvol list / | grep HOME | awk '{print $9}' | tail -1)"* ]]; then
        btrfs sub del "$d"
    fi
done
find /mnt/archlinux/btrbk_snapshots/ROOT/* -prune -type d | while IFS= read -r d; do
    if [[ -d "$d" && "$d" != *"$(btrfs subvol list / | grep ROOT | awk '{print $9}' | tail -1)"* ]]; then
        btrfs sub del "$d"

    fi
done
find /mnt/archlinux/refind_btrfs_rw_snapshots/* -prune -type d | while IFS= read -r d; do
    if [[ -d "$d" && "$d" != *"$(btrfs subvol list / | grep refind_btrfs_rw_snapshots | awk '{print $9}' | tail -1)"* ]]; then
        btrfs sub del "$d"
    fi
done
if [ -z "$(pgrep spotify)" ];then
    rm -rf /home/lucas/.cache/spotify/
fi
if [ -z "$(pgrep makepkg)" ];then
    rm -rf /home/lucas/.ccache/*
    if [ -z "$(pgrep yay)" ];then
        rm -rf /home/lucas/.cache/yay/*
    fi
fi
if [ -z "$(pgrep pacman)" ];then
    rm -rf /mnt/archlinux/PKG/*
fi
if [ -z "$(pgrep winetricks)" ];then
    rm -rf /home/lucas/.cache/winetricks/*
fi
