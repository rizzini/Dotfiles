#!/bin/bash
/usr/bin/killall -9 macro_d3_wiz.sh c_diablo_xb.sh pqiv xdotool xbindkeys;
/usr/bin/kill -9 "$(/usr/bin/pgrep Diablo)";

if [[ -z "$1" ]] || [[ "$1" != 'BR' && "$1" != 'US' ]]; then
    exit 1;
fi

if [ "$( /usr/bin/pgrep plasmashell)" ]; then
	if [[ $(/usr/bin/dbus-send --session --dest=org.freedesktop.Notifications --print-reply /org/freedesktop/Notifications org.freedesktop.DBus.Properties.Get string:org.freedesktop.Notifications  string:Inhibited) == *"false"* ]]; then
	    /usr/bin/xdotool key XF86Calculator;
	fi
fi

if [ "$1" == 'BR' ]; then
    WINEDEBUG=-all WINEFSYNC=1 WINEESYNC=1 WINEFSYNC_FUTEX2=1 WINEPREFIX=/home/lucas/.wine_d3/ /usr/bin/gamemoderun /opt/wine-tkg-staging-fsync-opt-git-7.0rc6.r0.g0111d074/bin/wine /mnt/archlinux/DIABLO_III/Diablo\ III.exe -launch &> /dev/null &
elif [ "$1" == 'US' ]; then 
     WINEDEBUG=-all WINEFSYNC=1 WINEESYNC=1 WINEFSYNC_FUTEX2=1 WINEPREFIX=/home/lucas/.wine_d3/ /usr/bin/gamemoderun /opt/wine-tkg-staging-fsync-opt-git-7.0rc6.r0.g0111d074/bin/wine /mnt/archlinux/DIABLO_III/Diablo\ III.exe -launch OnlineService.Matchmaking.ServerPool=Default &> /dev/null &
fi

counter=0
while [ $counter -le 20 ]; do
    counter=$(($counter + 1))
    if [ $((counter % 2)) -eq 0 ];then
        /usr/bin/killall -9 winedevice.exe; 
    fi
    /usr/bin/sleep 2;
done

if [ -n "$(ps -ef | /usr/bin/grep kwin | /usr/bin/grep -v grep | /usr/bin/grep -v  defunct | /usr/bin/awk '{print $2}')" ];then 
    if [[ -n "$(wmctrl -l | /usr/bin/grep -E 'Diablo III|Default - Wine desktop' | grep -v 'Konsole')" ]]; then 
        /usr/bin/xbindkeys &
    fi
    while [ -n "$(/usr/bin/wmctrl -l | /usr/bin/grep -E 'Diablo III|Default - Wine desktop' | grep -v 'Konsole')" ]; do
        /usr/bin/sleep 2;
    done
else
    if [ -n "$(/usr/bin/pgrep 'Diablo III.exe')" ]; then
        /usr/bin/xbindkeys &
    fi
    /usr/bin/kdialog --msgbox 'Fechar Diablo III';
fi

if [ -z "$(pgrep plasmashell)" ]; then
    /usr/bin/plasmashell &> /dev/null & disown $! &
fi

if [ -z "$(/usr/bin/ps -ef | /usr/bin/grep kwin | /usr/bin/grep -v grep | /usr/bin/grep -v  defunct | /usr/bin/awk '{print $2}')" ]; then
    /usr/bin/kwin_x11 --replace &> /dev/null & disown $! &
fi

while [[ -n "$(/usr/bin/pgrep c_diablo_xb.sh)" || -n "$(/usr/bin/pgrep pqiv)" || -n "$(/usr/bin/pgrep Diablo)" || -n "$(/usr/bin/pgrep xdotool)" || -n "$(/usr/bin/pgrep xbindkeys)" || -n "$(pgrep wine)" || -n "$( pgrep .exe)" ]]; do
    /usr/bin/killall -9 macro_d3_wiz.sh c_diablo_xb.sh pqiv xdotool xbindkeys;
    /usr/bin/kill -9 $(/usr/bin/pgrep Diablo);
    /usr/bin/kill -9 $(/usr/bin/pgrep .exe);
    /usr/bin/kill -9 $(/usr/bin/pgrep wine);
    /usr/bin/kill -9 $(/usr/bin/ps -aux | /usr/bin/grep -E "wine|windows" | /usr/bin/sed '$d' | /usr/bin/awk '{print $2}');
done

if [ "$(/usr/bin/pgrep plasmashell)" ]; then
	if [[ $(/usr/bin/dbus-send --session --dest=org.freedesktop.Notifications --print-reply /org/freedesktop/Notifications org.freedesktop.DBus.Properties.Get string:org.freedesktop.Notifications  string:Inhibited) == *"true"* ]]; then
	    /usr/bin/xdotool key XF86Calculator;
	fi
fi
