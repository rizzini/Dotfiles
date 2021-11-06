#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ -n "$(lspci -v | grep 'Kernel driver in use: nvidia')" && "$DISPLAY" == ":0" ]];then
    export KWIN_TRIPLE_BUFFER=1;
    export __GL_YIELD=USLEEP;
    export __GL_MaxFramesAllowed=1;
    export KWIN_COMPOSE=O2ES;
    export __GL_THREADED_OPTIMIZATION=1;
    export __GL_SHADER_DISK_CACHE=1;
    export __GL_SHADER_DISK_CACHE_PATH='/home/lucas/.cache/';
fi
