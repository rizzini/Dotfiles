#!/bin/bash
kwriteconfig5 --file=/home/lucas/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 155 --group Wallpaper --group org.kde.image --group General --key Image "file://$(find /home/lucas/Imagens/Wallpaper/ -type f -print0 | xargs -0 file --mime-type | grep -F 'image/' | cut -d ':' -f 1 | sort -R | head -n 1)"
