set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT "1"
source ~/.profile

if test $DISPLAY = ':0' 
    if ! string match -q "*archlinux/opengl_libs/nvidia/*" $LD_LIBRARY_PATH
    LD_LIBRARY_PATH "$LD_LIBRARY_PATH:/mnt/archlinux/opengl_libs/nvidia/"
    end
end
if test $DISPLAY = ':1' 
    set -e LD_LIBRARY_PATH
end

export PATH="/opt/VirtualGL/bin/:$PATH"

set -x WINEFSYNC 1
set -x WINEESYNC 1

# if ! set -q (lspci -v | grep 'Kernel driver in use: nvidia') ;
# __GL_YIELD USLEEP
# __GL_MaxFramesAllowed 1
# KWIN_COMPOSE O2ES
# __GL_THREADED_OPTIMIZATION 1
# KWIN_OPENGL_INTERFACE egl
# __GL_SHADER_DISK_CACHE 1
# __GL_SHADER_DISK_CACHE_PATH '/home/lucas/.cache/'
# KWIN_TRIPLE_BUFFER 1
# end

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


# alias h='__fzf_search_history'
alias k=kate
alias plasmashell='killall plasmashell & sleep 1 && /usr/bin/plasmashell &> /dev/null & disown $last_pid'
# Replace ls with exa
alias ls='exa -al --color=always --group-directories-first --icons' # preferred listing
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias big="expac -H M '%m\t%n' | sort -h | nl" # Sort installed packages according to size in MB (expac must be installed)
alias gitpkg='pacman -Q | grep -i "\-git" ' # List amount of -git packages
alias dolphin='dolphin . &> /dev/null & disown $last_pid'
alias jctl="journalctl -p 3 -xb"
alias syadm="sudo yadm -Y /etc/yadm"
#Recent Installed Packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
alias disown='disown $last_pid'
alias transmission-cli='transmission-cli --download-dir=/home/lucas/Downloads/'
alias cat='bat'

## Import colorscheme from 'wal' asynchronously
# if type "wal" >> /dev/null 2>&1
#      /usr/bin/cat ~/.cache/wal/sequences
# 
# end

# fisher install PatrickF1/fzf.fish 
