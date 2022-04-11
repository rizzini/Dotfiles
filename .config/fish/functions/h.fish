function h
    if [ -n "$argv[4]" ]
       __fzf_search_history "$argv[1]" "$argv[2]" "$argv[3]" "$argv[4]";
    else if [ -n "$argv[3]" ]    
        __fzf_search_history "$argv[1]" "$argv[2]" "$argv[3]";
    else if [ -n "$argv[2]" ]
        __fzf_search_history "$argv[1]" "$argv[2]";
    else if [ -n "$argv[1]" ]
        __fzf_search_history "$argv[1]";
    else if [ -z "$argv[1]" ]
        builtin history merge
        set --local --export SHELL (command --search fish)        
        set command_with_ts (
            builtin history --null --show-time="%m-%d %H:%M:%S | " |
            fzf --exact --read0 \
                --tiebreak=index \
                $query \
                $fzf_history_opts |
            string collect
        )
        if test $status -eq 0
            set command_selected (string split --max 1 " | " $command_with_ts)[2]
            commandline --replace -- $command_selected
        end
        commandline --function repaint
    end
end
