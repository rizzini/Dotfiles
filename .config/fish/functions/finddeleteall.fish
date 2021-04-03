function finddeleteall
        sudo find /mnt/archlinux/ROOT/* -iname "*$argv[1]*" -exec rm -rf {} \;
end
