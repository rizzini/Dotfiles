function k
    if [ -n "$argv[1]" ]
        /usr/bin/kate -n "$argv[1]" &> /dev/null &
    else if [ -z "$argv[1]" ]
        /usr/bin/kate -n &> /dev/null &
    end
end
