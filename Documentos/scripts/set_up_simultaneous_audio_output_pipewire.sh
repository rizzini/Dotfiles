#!/bin/bash
if test -h "/etc/wireplumber/main.lua.d/51-alsa-disable.lua"; then
    /usr/bin/sudo /usr/bin/rm -f /etc/wireplumber/main.lua.d/51-alsa-disable.lua
    /usr/bin/systemctl --user restart pipewire.service
    /usr/bin/sleep 1
    /usr/bin/pactl load-module module-null-sink media.class=Audio/Sink sink_name=Simultaneous channel_map=stereo
    /usr/bin/pw-link Simultaneous:monitor_FL alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1:playback_FL
    /usr/bin/pw-link Simultaneous:monitor_FR alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1:playback_FR
    /usr/bin/pw-link Simultaneous:monitor_FL alsa_output.pci-0000_00_1b.0.analog-stereo:playback_FL
    /usr/bin/pw-link Simultaneous:monitor_FR alsa_output.pci-0000_00_1b.0.analog-stereo:playback_FR
    /usr/bin/pactl set-sink-volume alsa_output.pci-0000_00_1b.0.analog-stereo 75%
    /usr/bin/pactl set-sink-volume alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1 100%
    /usr/bin/pactl set-sink-volume Simultaneous 45%
else
    /usr/bin/sudo /usr/bin/ln -sf /etc/wireplumber/main.lua.d/disable_minisystem/51-alsa-disable.lua /etc/wireplumber/main.lua.d/51-alsa-disable.lua
    /usr/bin/systemctl --user restart pipewire.service
    /usr/bin/sleep 1
    /usr/bin/pactl set-sink-volume alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1 40%
fi


# pactl load-module module-combine-sink sink_name=Simultaneous slaves=alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1,alsa_output.pci-0000_00_1b.0.analog-stereo

# pactl load-module module-null-sink media.class=Audio/Sink sink_name=Simultaneous channel_map=stereo
# pw-link Simultaneous:monitor_FL alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1:playback_FL
# pw-link Simultaneous:monitor_FR alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1:playback_FR
# pw-link Simultaneous:monitor_FL alsa_output.pci-0000_00_1b.0.analog-stereo:playback_FL
# pw-link Simultaneous:monitor_FR alsa_output.pci-0000_00_1b.0.analog-stereo:playback_FR
