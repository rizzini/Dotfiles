#!/bin/bash
killall -9 macro_d3_wiz.sh c_diablo_xb.sh pqiv xdotool xbindkeys;
kill -9 "$(pgrep Diablo)";

if [[ -z "$1" ]] || [[ "$1" != 'BR' && "$1" != 'US' ]]; then
    exit 1;
fi

if [[ $(dbus-send --session --dest=org.freedesktop.Notifications --print-reply /org/freedesktop/Notifications org.freedesktop.DBus.Properties.Get string:org.freedesktop.Notifications  string:Inhibited) == *"false"* ]]; then
    xdotool key XF86Calculator;
fi

if [ "$1" == 'BR' ]; then
    WINEDEBUG=-all WINEFSYNC=1 WINEESYNC=1 WINEFSYNC_FUTEX2=1 WINEPREFIX=/home/lucas/.wine_d3/ gamemoderun /opt/wine_tkg/bin/wine /mnt/archlinux/Diablo\ III/Diablo\ III.exe -launch &
elif [ "$1" == 'US' ]; then 
    WINEDEBUG=-all WINEFSYNC=1 WINEESYNC=1 WINEFSYNC_FUTEX2=1 WINEPREFIX=/home/lucas/.wine_d3/ gamemoderun /opt/wine_tkg/bin/wine /mnt/archlinux/Diablo\ III/Diablo\ III.exe -launch OnlineService.Matchmaking.ServerPool=Default &
fi
killall winedevice.exe
sleep 40 &&
killall winedevice.exe
if [ -n "$( wmctrl -l | grep 'Diablo III')" ]; then
#     killall -9 plasmashell
    xbindkeys &
#     /home/lucas/Documentos/scripts/c_diablo_xb.sh &
#     sleep 1 &&
#     renice -n 20 -p $(pgrep c_diablo_xb.sh)

fi

while [ -n "$( wmctrl -l | grep 'Diablo III')" ]; do
    sleep 2
done

if [ ! "$( pgrep plasmashell)" ]; then
    /usr/bin/plasmashell &> /dev/null & disown $! &
fi

sleep 1 &&

if [[ $(dbus-send --session --dest=org.freedesktop.Notifications --print-reply /org/freedesktop/Notifications org.freedesktop.DBus.Properties.Get string:org.freedesktop.Notifications  string:Inhibited) == *"true"* ]]; then
    xdotool key XF86Calculator;
fi

while [[ -n "$( pgrep c_diablo_xb.sh)" || -n "$(pgrep pqiv)" || -n "$( pgrep Diablo)" || -n "$( pgrep xdotool)" || -n "$( pgrep xbindkeys)" ]]; do
    killall -9 c_diablo_xb.sh pqiv xdotool xbindkeys;
    kill -9 $(pgrep Diablo);
done
