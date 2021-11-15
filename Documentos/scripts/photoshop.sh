#!/bin/bash
if [ -n "$1" ];then   
    WINEPREFIX=/home/lucas/.wine_photoshop/ /usr/bin/wine "c:\Program Files\Adobe\Adobe Photoshop CS6\Photoshop.exe" "$(/usr/bin/echo "Z:$1" | /usr/bin/sed '\,/$, !s,$,/,;\,^/, s,/,:/,2;s,^/,,;s,/,\\,g' | /usr/bin/rev | /usr/bin/cut -c2- | /usr/bin/rev)" &> /dev/null 
else
    WINEPREFIX=/home/lucas/.wine_photoshop/ /usr/bin/wine "c:\Program Files\Adobe\Adobe Photoshop CS6\Photoshop.exe" &> /dev/null 
fi
