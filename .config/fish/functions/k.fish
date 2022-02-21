function k
    if [ -n "$argv[1]" ]
        /usr/bin/kate -n "$argv[1]" &> /dev/null & disown $last_pid
    else if [ -z "$argv[1]" ]
        /usr/bin/kate -n &> /dev/null & disown $last_pid
    end
end
