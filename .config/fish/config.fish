set fish_greeting;
starship init fish | source
set VIRTUAL_ENV_DISABLE_PROMPT "1";
source ~/.profile;
# export PATH="/opt/VirtualGL/bin/:$PATH";
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end
alias plasmashell='/usr/bin/plasmashell --replace &> /dev/null & disown $last_pid';
alias ls='/usr/bin/exa -al --color=always --group-directories-first --icons';
alias grep='/usr/bin/grep --color=auto';
alias big="/usr/bin/expac -H M '%m\t%n' | /usr/bin/sort -h | nl";
alias gitpkg='/usr/bin/pacman -Q | grep -i "\-git" ';
alias syadm="/usr/bin/sudo /usr/bin/yadm -Y /etc/yadm";
alias rip="/usr/bin/expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | /usr/bin/sort | /usr/bin/tail -200 | /usr/bin/nl";
alias cat='/usr/bin/bat -p ';
