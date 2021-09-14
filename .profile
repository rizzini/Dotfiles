export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

set -x LANG pt_BR.UTF-8
set -x LC_ALL pt_BR.UTF-8
set -x LC_CTYPE pt_BR.UTF-8
set -x TERM konsole
set -x VISUAl nano
set -x EDITOR nano




if ! set -q (lspci -v | grep 'Kernel driver in use: nvidia') ;
    set -x KWIN_TRIPLE_BUFFER 1
    set -x __GL_YIELD USLEEP
    set -x __GL_MaxFramesAllowed 1
    set -x KWIN_COMPOSE O2ES
    set -x KWIN_OPENGL_INTERFACE egl
    set -x __GL_THREADED_OPTIMIZATION 1
    set -x __GL_SHADER_DISK_CACHE 1
    set -x __GL_SHADER_DISK_CACHE_PATH '/tmp/'
end
