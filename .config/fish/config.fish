set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT "1"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
source ~/.profile

if test $DISPLAY = ':0' 
    if ! string match -q "*archlinux/opengl_libs/nvidia/*" $LD_LIBRARY_PATH
        set -x LD_LIBRARY_PATH "$LD_LIBRARY_PATH:/mnt/archlinux/opengl_libs/nvidia/"
    end
end
if test $DISPLAY = ':1' 
    set -e LD_LIBRARY_PATH
end

export PATH="/opt/VirtualGL/bin/:$PATH"

set -x WINEFSYNC 1
set -x WINEESYNC 1

if ! set -q (lspci -v | grep 'Kernel driver in use: nvidia') ;
    set -x __GL_YIELD USLEEP
    set -x __GL_MaxFramesAllowed 1
    set -x KWIN_COMPOSE O2ES
    set -x KWIN_OPENGL_INTERFACE egl
    set -x __GL_THREADED_OPTIMIZATION 1
    set -x __GL_SHADER_DISK_CACHE 1
    set -x __GL_SHADER_DISK_CACHE_PATH '/home/lucas/.cache/'
    set -x KWIN_TRIPLE_BUFFER 1
end

## Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end


## Starship prompt
source ("/usr/bin/starship" init fish --print-full-init | psub)


## Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end


## Fish command history
function history
    builtin history --show-time='%F %T '
end

function backup --argument filename
    cp $filename $filename.bak
end


## Copy DIR1 DIR2
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
	set from (echo $argv[1] | trim-right /)
	set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end


## Useful aliases

##Custon
# alias h='__fzf_search_history'
alias mpv='mpv --geometry=50%:50% --autofit-larger=70%x70% --video-sync=display-resample'
alias k=kate
alias plasmashell='killall plasmashell & sleep 1 && /usr/bin/plasmashell &> /dev/null & disown $last_pid'
# Replace ls with exa
alias ls='exa -al --color=always --group-directories-first --icons' # preferred listing


# Replace some more things with better alternatives
[ ! -x /usr/bin/bat ] && [ -x /usr/bin/cat ] && alias cat='bat'

# Common use
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias big="expac -H M '%m\t%n' | sort -h | nl"              # Sort installed packages according to size in MB (expac must be installed)
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'			# List amount of -git packages
alias firefox_i="/bin/bash -c 'LD_LIBRARY_PATH='' DISPLAY=:1 vglrun -d :1  /usr/lib/firefox/firefox --display=:0 & disown $last_pid'"
alias dolphin='dolphin . &> /dev/null & disown $last_pid'
#get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

#Recent Installed Packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# Replace yay with paru
[ ! -x /usr/bin/yay ] && [ -x /usr/bin/paru ] && alias yay='paru'


## Import colorscheme from 'wal' asynchronously
# if type "wal" >> /dev/null 2>&1
#      /usr/bin/cat ~/.cache/wal/sequences
# 
# end

# fisher install PatrickF1/fzf.fish 
