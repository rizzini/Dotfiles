#!/bin/bash
if [ -n "$1" ];then
    WINEPREFIX=/home/lucas/.wine_photoshop/ wine /home/lucas/.wine_photoshop/drive_c/Program\ Files/Adobe/Adobe\ Photoshop\ CS6/Photoshop.exe "Z:$1"
else
    WINEPREFIX=/home/lucas/.wine_photoshop/ wine /home/lucas/.wine_photoshop/drive_c/Program\ Files/Adobe/Adobe\ Photoshop\ CS6/Photoshop.exe
fi
