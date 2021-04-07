
function h
    if [ -n "$argv[4]" ]
        history | cut -c21-999 | grep "$argv[1]" | grep "$argv[2]" | grep "$argv[3]" | grep "$argv[4]" | fzf | xclip -i -sel clip;
    else if [ -n "$argv[3]" ]    
        history | cut -c21-999 | grep "$argv[1]" | grep "$argv[2]" | grep "$argv[3]" | fzf | xclip -i -sel clip;
    else if [ -n "$argv[2]" ]
        history | cut -c21-999 | grep "$argv[1]" | grep "$argv[2]" | fzf | xclip -i -sel clip;
    else if [ -n "$argv[1]" ]
        history | cut -c21-999 | grep "$argv[1]" | fzf | xclip -i -sel clip;
    else if [ -z "$argv[1]" ]
        history | cut -c21-999 | fzf | xclip -i -sel clip;
    end
end
