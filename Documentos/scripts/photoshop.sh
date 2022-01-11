#!/bin/bash
if [ -n "$1" ];then   
    WINEPREFIX=/home/lucas/.wine_photoshop/ /opt/wine-tkg-staging-fsync-opt-git-7.0rc4.r3.gee4ca71a/bin/wine "c:\Program Files\Adobe\Adobe Photoshop CS6 (64 Bit)\Photoshop.exe" "$(/usr/bin/echo "Z:$1" | /usr/bin/sed '\,/$, !s,$,/,;\,^/, s,/,:/,2;s,^/,,;s,/,\\,g' | /usr/bin/rev | /usr/bin/cut -c2- | /usr/bin/rev)" &> /dev/null 
else
    WINEPREFIX=/home/lucas/.wine_photoshop/ /opt/wine-tkg-staging-fsync-opt-git-7.0rc4.r3.gee4ca71a/bin/wine "c:\Program Files\Adobe\Adobe Photoshop CS6 (64 Bit)\Photoshop.exe" &> /dev/null 
fi


