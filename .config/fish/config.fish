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
alias plasmashell='kquitapp5 plasmashell &> /dev/null & sleep 1 && kstart5 /usr/bin/plasmashell &> /dev/null & disown $last_pid';
alias ls='exa -al --color=always --group-directories-first --icons';
alias grep='grep --color=auto';
alias big="expac -H M '%m\t%n' | sort -h | nl";
alias gitpkg='pacman -Q | grep -i "\-git" ';
alias syadm="sudo yadm -Y /etc/yadm";
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl";
alias cat='bat -p ';
