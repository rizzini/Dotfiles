function findall
    sudo find /mnt/archlinux/ROOT/* -iname "*$argv[1]*" -not -path "*refind_btrfs_rw_snapshots*" | less
end
