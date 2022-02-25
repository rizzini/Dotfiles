function d
    if [ -z "$argv[1]" ]
        /usr/bin/dolphin . >&2 /dev/null & disown $last_pid
    else if [ -n "$argv[1]" ]
        /usr/bin/dolphin "$argv[1]" >&2 /dev/null & disown $last_pid
    end
end
