#!/bin/bash
if [ -n "$1" ];then   
    WINEPREFIX=/home/lucas/.wine_photoshop/ wine "c:\Program Files\Adobe\Adobe Photoshop CS6\Photoshop.exe" "$(echo "Z:$1" | sed '\,/$, !s,$,/,;\,^/, s,/,:/,2;s,^/,,;s,/,\\,g' | rev | cut -c2- | rev)" &> /dev/null 
else
    WINEPREFIX=/home/lucas/.wine_photoshop/ wine "c:\Program Files\Adobe\Adobe Photoshop CS6\Photoshop.exe" &> /dev/null 
fi
