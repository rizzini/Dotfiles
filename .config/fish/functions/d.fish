function d
    if [ -n "$argv[1]" ]
        /usr/bin/dolphin "$argv[1]" &> /dev/null & disown $last_pid
    else if [ -z "$argv[1]" ]
        /usr/bin/dolphin &> /dev/null & disown $last_pid
    end
end
