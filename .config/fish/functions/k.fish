function k
    if [ -n "$argv[1]" ]
    /usr/bin/kate -n "$argv[1]" &> /dev/null &
    end
end
