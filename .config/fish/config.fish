set fish_greeting;
set VIRTUAL_ENV_DISABLE_PROMPT "1";
source ~/.profile;

if test $DISPLAY = ':0' 
    if ! string match -q "*archlinux/opengl_libs/nvidia/*" $LD_LIBRARY_PATH
        set -x LD_LIBRARY_PATH "$LD_LIBRARY_PATH:/mnt/archlinux/opengl_libs/nvidia/";
    end
end


export PATH="/opt/VirtualGL/bin/:$PATH";

if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

source ("/usr/bin/starship" init fish --print-full-init | psub);

alias k=kate;
alias plasmashell='killall plasmashell &> /dev/null & sleep 1 && /usr/bin/plasmashell &> /dev/null & disown $last_pid';
alias ls='exa -al --color=always --group-directories-first --icons';
alias grep='grep --color=auto';
alias big="expac -H M '%m\t%n' | sort -h | nl";
alias gitpkg='pacman -Q | grep -i "\-git" ';
alias dolphin='dolphin . &> /dev/null & disown $last_pid';
alias jctl="journalctl -p 3 -xb";
alias syadm="sudo yadm -Y /etc/yadm";
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl";
alias disown='disown $last_pid';
alias cat='bat -p ';
alias torrent='transmission-cli --download-dir=/home/lucas/Downloads/ '
## Import colorscheme from 'wal' asynchronously
# if type "wal" >> /dev/null 2>&1
#      /usr/bin/cat ~/.cache/wal/sequences
# 
# end

# fisher install PatrickF1/fzf.fish 
