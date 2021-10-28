set fish_greeting;
set VIRTUAL_ENV_DISABLE_PROMPT "1";
source ~/.profile;

if test $DISPLAY = ':0' 
    if ! string match -q "*archlinux/opengl_libs/nvidia/*" $LD_LIBRARY_PATH
        set -x LD_LIBRARY_PATH "$LD_LIBRARY_PATH:/mnt/archlinux/opengl_libs/nvidia/";
    end
end
if test $DISPLAY = ':1' 
    set -e LD_LIBRARY_PATH;
end

export PATH="/opt/VirtualGL/bin/:$PATH";

# set -x WINEFSYNC 1;
# set -x WINEESYNC 1;

# if ! set -q (lspci -v | grep 'Kernel driver in use: nvidia') ;
#     set -x __GL_YIELD USLEEP
#     set -x __GL_MaxFramesAllowed 1
#     set -x KWIN_COMPOSE O2ES
#     set -x __GL_THREADED_OPTIMIZATION 1
#     set -x KWIN_OPENGL_INTERFACE egl
#     set -x __GL_SHADER_DISK_CACHE 1
#     set -x __GL_SHADER_DISK_CACHE_PATH '/home/lucas/.cache/'
#     set -x KWIN_TRIPLE_BUFFER 1
# end

## Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

## Starship prompt
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
alias transmission-cli='transmission-cli --download-dir=/home/lucas/Downloads/';
alias cat='bat';

## Import colorscheme from 'wal' asynchronously
# if type "wal" >> /dev/null 2>&1
#      /usr/bin/cat ~/.cache/wal/sequences
# 
# end

# fisher install PatrickF1/fzf.fish 
