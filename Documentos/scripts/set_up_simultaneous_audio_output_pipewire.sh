#!/bin/bash
if test -f "/usr/share/wireplumber/main.lua.d/51-alsa-disable.lua"; then
    sudo /usr/bin/mv /usr/share/wireplumber/main.lua.d/51-alsa-disable.lua /usr/share/wireplumber/main.lua.d/51-alsa-disable.lua.tmp
    systemctl --user restart pipewire.service
    pactl load-module module-combine-sink sink_name=Simultaneous slaves=alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1,alsa_output.pci-0000_00_1b.0.analog-stereo
    pactl set-sink-volume alsa_output.pci-0000_00_1b.0.analog-stereo 100%
    pactl set-sink-volume alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1 100%
    pactl set-sink-volume Simultaneous 45%
elif test -f "/usr/share/wireplumber/main.lua.d/51-alsa-disable.lua.tmp"; then
    sudo /usr/bin/mv /usr/share/wireplumber/main.lua.d/51-alsa-disable.lua.tmp /usr/share/wireplumber/main.lua.d/51-alsa-disable.lua
    systemctl --user restart pipewire.service
fi

# pactl load-module module-combine-sink sink_name=Simultaneous slaves=alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1,alsa_output.pci-0000_00_1b.0.analog-stereo

# pactl load-module module-null-sink media.class=Audio/Sink sink_name=Simultaneous channel_map=stereo
# pw-link Simultaneous:monitor_FL alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1:playback_FL
# pw-link Simultaneous:monitor_FR alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1:playback_FR
# pw-link Simultaneous:monitor_FL alsa_output.pci-0000_00_1b.0.analog-stereo:playback_FL
# pw-link Simultaneous:monitor_FR alsa_output.pci-0000_00_1b.0.analog-stereo:playback_FR
