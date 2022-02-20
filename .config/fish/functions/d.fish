function d
    if [ -n "$argv[1]" ]
    /usr/bin/dolphin "$argv[1]" &> /dev/null &
    end
end
