#!/bin/bash
/usr/bin/kwriteconfig5 --file=/home/lucas/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 155 --group Wallpaper --group org.kde.image --group General --key Image "file://$(/usr/bin/find /home/lucas/Imagens/Wallpaper/ -type f -print0 | /usr/bin/xargs -0 file --mime-type | /usr/bin/grep -F 'image/' | /usr/bin/cut -d ':' -f 1 | /usr/bin/sort -R | /usr/bin/head -n 1)"
touch /home/lucas/Área\ de\ Trabalho/1
