function findhall
    sudo find /mnt/archlinux/HOME/* -iname "*$argv[1]*" | cut -c27- | awk '$0="~/"$0'
end
