function findhall
    sudo find /mnt/archlinux/HOME/* -iname "*$argv[1]*" | cut -c20-
end
