#!/bin/bash
killall -9 macro_d3_wiz.sh c_diablo_xb.sh pqiv xdotool xbindkeys;
kill -9 "$(pgrep Diablo)";

if [[ -z "$1" ]] || [[ "$1" != 'BR' && "$1" != 'US' ]]; then
    exit 1;
fi

if [ "$( pgrep plasmashell)" ]; then
	if [[ $(dbus-send --session --dest=org.freedesktop.Notifications --print-reply /org/freedesktop/Notifications org.freedesktop.DBus.Properties.Get string:org.freedesktop.Notifications  string:Inhibited) == *"false"* ]]; then
	    xdotool key XF86Calculator;
	fi
fi

if [ "$1" == 'BR' ]; then
    WINEDEBUG=-all WINEFSYNC=1 WINEESYNC=1 WINEFSYNC_FUTEX2=1 WINEPREFIX=/home/lucas/.wine_d3/ gamemoderun /opt/wine_tkg/bin/wine /mnt/archlinux/Diablo\ III/Diablo\ III.exe -launch &
elif [ "$1" == 'US' ]; then 
    WINEDEBUG=-all WINEFSYNC=1 WINEESYNC=1 WINEFSYNC_FUTEX2=1 WINEPREFIX=/home/lucas/.wine_d3/ gamemoderun /opt/wine_tkg/bin/wine /mnt/archlinux/Diablo\ III/Diablo\ III.exe -launch OnlineService.Matchmaking.ServerPool=Default &
fi

counter=0
while [ $counter -le 60 ]; do
    counter=$(($counter + 2))
    killall -9 winedevice.exe
    sleep 2
done

if [ -n "$(pgrep kwin)" ];then 
    if [ -n "$(wmctrl -l | grep 'Diablo III')" ]; then 
        xbindkeys &
    fi
    while [ -n "$(wmctrl -l | grep 'Diablo III')" ]; do
        sleep 2
    done
else
    if [ -n "$(pgrep 'Diablo III.exe')" ]; then
        xbindkeys &
    fi
    while [ -n "$(pgrep 'Diablo III.exe')" ]; do
        sleep 2
    done
fi

if [ ! "$( pgrep plasmashell)" ]; then
    /usr/bin/plasmashell &> /dev/null & disown $! &
fi

if [ ! "$( pgrep plasmashell)" ]; then
    /usr/bin/kwin_x11 --replace &> /dev/null & disown $! &
fi

while [[ -n "$( pgrep c_diablo_xb.sh)" || -n "$(pgrep pqiv)" || -n "$( pgrep Diablo)" || -n "$( pgrep xdotool)" || -n "$( pgrep xbindkeys)" || -n "$(pgrep wine)" || -n "$( pgrep .exe)" ]]; do
    killall -9 macro_d3_wiz.sh c_diablo_xb.sh pqiv xdotool xbindkeys;
    kill -9 $(pgrep Diablo);
    kill -9 $(pgrep .exe)
    kill -9 $(pgrep wine)
    kill -9 $(ps -aux | grep -E "wine|windows" | sed '$d' |  awk '{print $2}')
done

if [ "$( pgrep plasmashell)" ]; then
	if [[ $(dbus-send --session --dest=org.freedesktop.Notifications --print-reply /org/freedesktop/Notifications org.freedesktop.DBus.Properties.Get string:org.freedesktop.Notifications  string:Inhibited) == *"true"* ]]; then
	    xdotool key XF86Calculator;
	fi
fi
