#!/bin/bash
pulseeffects=0
if [ -n "$(/usr/bin/pgrep easyeffects)" ]; then
    pulseeffects=1
    /home/lucas/Documentos/scripts/easy.effects_in_background.sh
fi
if [ ! -h "/etc/wireplumber/main.lua.d/51-alsa-disable.lua" ];then
    get_current_volume_simulatenous="$(pactl get-sink-volume 'Simultaneous' | /usr/bin/awk '{print $12}')";
    /usr/bin/sudo /usr/bin/ln -sf /etc/wireplumber/main.lua.d/disable_minisystem/51-alsa-disable.lua /etc/wireplumber/main.lua.d/51-alsa-disable.lua;
    /usr/bin/systemctl --user restart pipewire.service wireplumber.service;
    /usr/bin/sleep 1;
    /usr/bin/pactl set-sink-volume alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1 "$get_current_volume_simulatenous";
elif [ -h "/etc/wireplumber/main.lua.d/51-alsa-disable.lua" ]; then
    get_current_volume_hdmi="$(pactl get-sink-volume 'alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1' | /usr/bin/awk '{print $12}')";
    /usr/bin/sudo /usr/bin/rm -f /etc/wireplumber/main.lua.d/51-alsa-disable.lua;
    /usr/bin/systemctl --user restart pipewire.service wireplumber.service;
    /usr/bin/sleep 1
    while ! /usr/bin/pw-cli list-objects Node | /usr/bin/grep -q Simultaneous; do
        /usr/bin/pactl load-module module-null-sink media.class=Audio/Sink sink_name=Simultaneous channel_map=stereo;
        sleep 0.2
    done
    sleep 1
    while ! pw-link -l | grep -q 'alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1:playback_FL';do
        /usr/bin/pw-link Simultaneous:monitor_FL alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1:playback_FL;
        sleep 0.2
    done
    while ! pw-link -l | grep -q 'alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1:playback_FR';do
        /usr/bin/pw-link Simultaneous:monitor_FR alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1:playback_FR;
        sleep 0.2
    done
    while ! pw-link -l | grep -q 'alsa_output.pci-0000_00_1b.0.analog-stereo:playback_FL';do
        /usr/bin/pw-link Simultaneous:monitor_FL alsa_output.pci-0000_00_1b.0.analog-stereo:playback_FL;
        sleep 0.2
    done
    while ! pw-link -l | grep -q 'alsa_output.pci-0000_00_1b.0.analog-stereo:playback_FR';do
        /usr/bin/pw-link Simultaneous:monitor_FR alsa_output.pci-0000_00_1b.0.analog-stereo:playback_FR;
        sleep 0.2
    done
    /usr/bin/pactl set-sink-volume alsa_output.pci-0000_00_1b.0.analog-stereo 100%;
    /usr/bin/pactl set-sink-volume alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1 100%;
    /usr/bin/pactl set-sink-volume Simultaneous "$get_current_volume_hdmi";
    /usr/bin/pactl set-default-sink Simultaneous;
fi
if [ $pulseeffects == 1  ];then
    sleep 1
    /home/lucas/Documentos/scripts/easy.effects_in_background.sh
fi
