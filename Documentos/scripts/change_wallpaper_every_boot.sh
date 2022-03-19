#!/bin/sh

Backgrounds_Source="$HOME/Imagens/Wallpaper/"
Random_Background=$(find "$Backgrounds_Source" -type f -print0 | xargs -0 file --mime-type | grep -F 'image/' | cut -d ':' -f 1 | sort -R | head -n 1)
Background_Image="$HOME/.default_wallpaper.jpg"

if [ -d "$Backgrounds_Source" ]; then
    if [ -n "$Random_Background" ]; then
        ln -Pfn "$Random_Background" "$Background_Image"
    fi
fi
