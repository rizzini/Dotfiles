function __fzf_search_history --description "Search command history. Replace the command line with the selected command."
    if [ -n "$argv[4]" ]
        set query "-q "$argv[1]" "$argv[2]" "$argv[3]" "$argv[4]"";
    else if [ -n "$argv[3]" ]    
        set query "-q "$argv[1]" "$argv[2]" "$argv[3]"";
    else if [ -n "$argv[2]" ]
        set query "-q "$argv[1]" "$argv[2]"";
    else if [ -n "$argv[1]" ]
        set query "-q "$argv[1]"";
    else if [ -z "$argv[1]" ]
        set query ' '
    end
    # history merge incorporates history changes from other fish sessions
    builtin history merge

    # Make sure that fzf uses fish so we can run fish_indent.
    # See similar comment in __fzf_search_shell_variables.fish.
    set --local --export SHELL (command --search fish)
    
    set command_with_ts (
        # Reference https://devhints.io/strftime to understand strftime format symbols
        builtin history --null --show-time="%m-%d %H:%M:%S | " |
        fzf --exact --read0 \
            --tiebreak=index \
            $query \
            # preview current command using fish_ident in a window at the bottom 3 lines tall
#             --preview="echo -- {4..} | fish_indent --ansi" \
#             --preview-window="bottom:3:wrap" \
            $fzf_history_opts |
        string collect
    )

    if test $status -eq 0
        set command_selected (string split --max 1 " | " $command_with_ts)[2]
        commandline --replace -- $command_selected
    end

    commandline --function repaint
end
