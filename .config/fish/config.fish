set fish_greeting;
set VIRTUAL_ENV_DISABLE_PROMPT "1";
source ~/.profile;

# set XORG (grep nvidia /etc/X11/xorg.conf)
# if test -n "$DISPLAY";
#     if ! set -q $XORG;
#         if ! string match -q "*opengl_libs*" $LD_LIBRARY_PATH
#             set -x LD_LIBRARY_PATH "$LD_LIBRARY_PATH:/mnt/archlinux/opengl_libs/nvidia/";
#         end
#         if test -d "$HOME/.cache/";
#             export __GL_SHADER_DISK_CACHE_PATH="$HOME/.cache/";
#         else
#             mkdir -p $HOME/.cache/
#             export __GL_SHADER_DISK_CACHE_PATH="$HOME/.cache/";
#         end
#         export KWIN_TRIPLE_BUFFER=1;
#         export __GL_YIELD=USLEEP;
#         export __GL_MaxFramesAllowed=1;
#         export KWIN_COMPOSE=O2ES;
#         export __GL_THREADED_OPTIMIZATION=1;
#         export __GL_SHADER_DISK_CACHE=1;
#     end
# end


# export PATH="/opt/VirtualGL/bin/:$PATH";

if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

source ("/usr/bin/starship" init fish --print-full-init | psub);

alias plasmashell='kquitapp5 plasmashell &> /dev/null & sleep 1 && kstart5 /usr/bin/plasmashell &> /dev/null & disown $last_pid';
alias ls='exa -al --color=always --group-directories-first --icons';
alias grep='grep --color=auto';
alias big="expac -H M '%m\t%n' | sort -h | nl";
alias gitpkg='pacman -Q | grep -i "\-git" ';
alias syadm="sudo yadm -Y /etc/yadm";
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl";
alias cat='bat -p ';
alias mem='watch -n0.5 "Documentos/scripts/mem_monitor_taskbar.sh & Documentos/scripts/disk_monitor_taskbar.sh &"'
## Import colorscheme from 'wal' asynchronously
# if type "wal" >> /dev/null 2>&1
#      /usr/bin/cat ~/.cache/wal/sequences
# 
# end

# fisher install PatrickF1/fzf.fish 
