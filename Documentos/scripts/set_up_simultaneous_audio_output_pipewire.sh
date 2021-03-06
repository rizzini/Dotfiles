#!/bin/bash
pulseeffects=0
if [ -n "$(/usr/bin/pgrep easyeffects)" ]; then
    pulseeffects=1
    /home/lucas/Documentos/scripts/easy.effects_in_background.sh
fi
if [ ! -h "/etc/wireplumber/main.lua.d/51-alsa-disable.lua" ];then
    get_current_volume="$(pactl get-sink-volume 'Simultaneous' | /usr/bin/awk '{print $12}')";
    /usr/bin/sudo /usr/bin/ln -sf /etc/wireplumber/main.lua.d/disable_minisystem/51-alsa-disable.lua /etc/wireplumber/main.lua.d/51-alsa-disable.lua;
    /usr/bin/systemctl --user restart pipewire.service wireplumber.service;
    /usr/bin/sleep 1;
    /usr/bin/pactl set-sink-volume alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1 "$get_current_volume";
elif [ -h "/etc/wireplumber/main.lua.d/51-alsa-disable.lua" ]; then
    get_current_volume="$(pactl get-sink-volume 'alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1' | /usr/bin/awk '{print $12}')";
    /usr/bin/sudo /usr/bin/rm -f /etc/wireplumber/main.lua.d/51-alsa-disable.lua;
    /usr/bin/systemctl --user restart pipewire.service wireplumber.service;
    /usr/bin/sleep 1
    #pactl load-module module-combine-sink sink_name=combination-sink sink_properties=device.description=Saída_Combinada slaves=alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1,alsa_output.pci-0000_00_1b.0.analog-stereo channels=2
    while ! /usr/bin/pw-cli list-objects Node | /usr/bin/grep -q Simultaneous; do
        /usr/bin/pactl load-module module-null-sink media.class=Audio/Sink sink_name=Simultaneous channel_map=stereo;
        /usr/bin/sleep 0.2
    done
    /usr/bin/sleep 0.1
    while ! pw-link -l | /usr/bin/grep -q 'alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1:playback_FL';do
        /usr/bin/pw-link Simultaneous:monitor_FL alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1:playback_FL;
        /usr/bin/sleep 0.2
    done
    /usr/bin/sleep 0.1
    while ! pw-link -l | /usr/bin/grep -q 'alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1:playback_FR';do
        /usr/bin/pw-link Simultaneous:monitor_FR alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1:playback_FR;
        /usr/bin/sleep 0.2
    done
    /usr/bin/sleep 0.1
    while ! pw-link -l | /usr/bin/grep -q 'alsa_output.pci-0000_00_1b.0.analog-stereo:playback_FL';do
        /usr/bin/pw-link Simultaneous:monitor_FL alsa_output.pci-0000_00_1b.0.analog-stereo:playback_FL;
        /usr/bin/sleep 0.2
    done
    /usr/bin/sleep 0.1
    while ! pw-link -l | /usr/bin/grep -q 'alsa_output.pci-0000_00_1b.0.analog-stereo:playback_FR';do
        /usr/bin/pw-link Simultaneous:monitor_FR alsa_output.pci-0000_00_1b.0.analog-stereo:playback_FR;
        /usr/bin/sleep 0.2
    done
    /usr/bin/sleep 0.2
    /usr/bin/pactl set-sink-volume alsa_output.pci-0000_00_1b.0.analog-stereo 100%;
    /usr/bin/pactl set-sink-volume alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1 100%;
    /usr/bin/pactl set-sink-volume Simultaneous "$get_current_volume";
    /usr/bin/pactl set-default-sink Simultaneous;
fi
if [ $pulseeffects == 1 ];then
    /usr/bin/sleep 1
    /home/lucas/Documentos/scripts/easy.effects_in_background.sh
fi
