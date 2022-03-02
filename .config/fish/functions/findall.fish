function findall
    sudo find / -iname "*$argv[1]*" -not -path "/mnt/*" 2> /dev/null
end
