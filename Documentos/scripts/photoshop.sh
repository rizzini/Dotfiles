#!/bin/bash
if [ -n "$1" ];then   
    path=$(echo "Z:$1" | sed '\,/$, !s,$,/,;\,^/, s,/,:/,2;s,^/,,;s,/,\\,g' | rev | cut -c2- | rev)
    WINEPREFIX=/home/lucas/.wine_photoshop/ wine "c:\Program Files\Adobe\Adobe Photoshop CS6\Photoshop.exe" "$path" &> /dev/null 
else
    WINEPREFIX=/home/lucas/.wine_photoshop/ wine /home/lucas/.wine_photoshop/drive_c/Program\ Files/Adobe/Adobe\ Photoshop\ CS6/Photoshop.exe &> /dev/null 
fi
