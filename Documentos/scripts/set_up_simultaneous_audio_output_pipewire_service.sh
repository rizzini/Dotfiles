#!/bin/bash
/usr/bin/sleep 1
if [[ "$1" == "link" && ! -h "/etc/wireplumber/main.lua.d/51-alsa-disable.lua" ]];then
    if ! pw-cli list-objects Node | grep -q Simultaneous
    then
    while ! /usr/bin/pw-cli list-objects Node | /usr/bin/grep -q Simultaneous; do
        /usr/bin/pactl load-module module-null-sink media.class=Audio/Sink sink_name=Simultaneous channel_map=stereo;
        sleep 0.2
    done
    sleep 0.1
    while ! pw-link -l | grep -q 'alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1:playback_FL';do
        /usr/bin/pw-link Simultaneous:monitor_FL alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1:playback_FL;
        sleep 0.2
    done
    sleep 0.1
    while ! pw-link -l | grep -q 'alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1:playback_FR';do
        /usr/bin/pw-link Simultaneous:monitor_FR alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1:playback_FR;
        sleep 0.2
    done
    sleep 0.1
    while ! pw-link -l | grep -q 'alsa_output.pci-0000_00_1b.0.analog-stereo:playback_FL';do
        /usr/bin/pw-link Simultaneous:monitor_FL alsa_output.pci-0000_00_1b.0.analog-stereo:playback_FL;
        sleep 0.2
    done
    sleep 0.1
    while ! pw-link -l | grep -q 'alsa_output.pci-0000_00_1b.0.analog-stereo:playback_FR';do
        /usr/bin/pw-link Simultaneous:monitor_FR alsa_output.pci-0000_00_1b.0.analog-stereo:playback_FR;
        sleep 0.2
    done
    fi
fi
