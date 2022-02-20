function d
    if [ -n "$argv[1]" ]
        /usr/bin/dolphin "$argv[1]" &> /dev/null &
    else if [ -z "$argv[1]" ]
        /usr/bin/dolphin &> /dev/null &
    end
end
