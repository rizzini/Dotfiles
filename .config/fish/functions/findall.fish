function findall
    sudo find / -path '/mnt' -prune -o -iname "*$argv[1]*" 2> /dev/null | head -n -1
end
