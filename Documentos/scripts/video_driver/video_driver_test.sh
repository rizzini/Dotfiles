#!/bin/bash
set -x

systemctl isolate multi-user.target;
systemctl isolate graphical.target;
/usr/bin/systemctl stop sddm;
killall -9 --user lucas;
sleep 1;
while [[ -n "$(/usr/bin/pgrep plasmashell)" && -n "$(/usr/bin/pgrep kwin_x11)" && -n "$(/usr/bin/pgrep klauncher)" && -n "$(/usr/bin/pgrep Xorg)" && -n "$(/usr/bin/fuser -v /dev/dri/card0)" && -n "$(/usr/bin/fuser -v /dev/dri/card1)" ]];
do
    /usr/bin/killall -9 plasmashell;
    /usr/bin/killall -9 kwin_x11;
    /usr/bin/killall -9 Xorg;
    /usr/bin/killall -9 X;
    /usr/bin/killall -9 klauncher;
    /usr/bin/sleep 0.2
done

sleep 3
echo 0 > /sys/class/vtconsole/vtcon0/bind
echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind
echo '0000:01.00.0' /sys/bus/pci/drivers/nvidia/unbind
sleep 1
modprobe nouveau
rmmod -f nvidia_drm
rmmod -f nvidia_modeset
rmmod -f drm_kms_helper
rmmod -f nvidia
rmmod -f i2c_nvidia_gpu
rmmod -f drm
sleep 1
echo 'blacklist nvidia' > /etc/modprobe.d/blacklist.conf
echo 1 > /sys/class/vtconsole/vtcon0/bind
echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/bind
sleep 1
echo '0000:01.00.0' /sys/bus/pci/drivers/nouveau/bind
sleep 1
# systemctl restart sddm

