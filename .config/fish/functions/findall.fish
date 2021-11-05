function findall
sudo find /mnt/archlinux/ROOT/* -iname "*$argv[1]*" -path /refind_btrfs_rw_snapshots -prune
end
