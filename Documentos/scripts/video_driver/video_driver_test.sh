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
    /usr/bin/pkill -9 x
    /usr/bin/sleep 0.2
done

sleep 1
echo 0 > /sys/class/vtconsole/vtcon0/bind
echo 0 > /sys/class/vtconsole/vtcon1/bind
echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind
echo '0000:01.00.0' /sys/bus/pci/drivers/nvidia/unbind
sleep 1

rmmod -f i2c_nvidia_gpu
rmmod -f nvidia_drm
rmmod -f nvidia_modeset
rmmod -f drm_kms_helper
rmmod -f nvidia
rmmod -f i2c_nvidia_gpu
rmmod -f drm
modprobe nouveau
echo 1 > /sys/class/vtconsole/vtcon0/bind
echo 1 > /sys/class/vtconsole/vtcon1/bind
echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/bind

sleep 1
echo 'blacklist nvidia' > /etc/modprobe.d/blacklist.conf
sleep 5
echo '0000:01.00.0' /sys/bus/pci/drivers/nouveau/bind
sleep 1
# systemctl restart sddm

