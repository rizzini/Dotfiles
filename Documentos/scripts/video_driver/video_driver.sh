#!/bin/bash
set -x

    
SCRIPTPATH=$(/usr/bin/dirname "$(/usr/bin/readlink -f "$0")");
/usr/bin/echo $SCRIPTPATH;

if [ -n "$(lspci -v | grep 'Kernel driver in use: nouveau')" ]; then
    echo '#blacklist nvidia' > /etc/modprobe.d/blacklist.conf     
#   rmmod nouveau
#   rmmod ttm
#   rmmod drm_kms_helper
#   rmmod drm
    /usr/bin/cp $SCRIPTPATH/proprietario/xorg.conf /etc/X11/;
    /usr/bin/pacman --noconfirm -U $SCRIPTPATH/proprietario/lib32-nvidia-340xx-utils-340.108-1-x86_64.pkg.tar.zst $SCRIPTPATH/proprietario/lib32-opencl-nvidia-340xx-340.108-1-x86_64.pkg.tar.zst $SCRIPTPATH/proprietario/nvidia-340xx-utils-340.108-1-x86_64.pkg.tar.zst $SCRIPTPATH/proprietario/opencl-nvidia-390xx-390.141-1-x86_64.pkg.tar.zst $SCRIPTPATH/proprietario/nvidia-340xx-340.108-18-x86_64.pkg.tar.zst &> /dev/null;  
    /usr/bin/reboot
elif [ -n "$(lspci -v | grep 'Kernel driver in use: nvidia')" ]; then
    /usr/bin/pacman --noconfirm -R lib32-opencl-nvidia-340xx opencl-nvidia-390xx nvidia-340xx nvidia-340xx-utils lib32-nvidia-340xx-utils &> /dev/null;
    /usr/bin/rm /etc/X11/xorg.conf;
    /usr/bin/modprobe nouveau;
    /usr/bin/systemctl stop sddm;
    sleep 1
    killall -9 --user lucas
    while [[ -n "$(/usr/bin/pgrep plasmashell)" && "$(/usr/bin/pgrep kwin_x11)" && "$(/usr/bin/pgrep klauncher)" && "$(/usr/bin/pgrep Xorg)" && -n "$(/usr/bin/fuser -v /dev/dri/card0)" && -n "$(/usr/bin/fuser -v /dev/dri/card1)" ]];
    do
        /usr/bin/killall -9 plasmashell;
        /usr/bin/killall -9 kwin_x11;
        /usr/bin/killall -9 Xorg;
        /usr/bin/killall -9 X;
        /usr/bin/killall -9 klauncher;
        /usr/bin/sleep 0.2
    done    
    echo 0 > /sys/class/vtconsole/vtcon0/bind
    echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind
    echo '0000:01.00.0' /sys/bus/pci/drivers/nvidia/unbind
    sleep 1
    modprobe -r nvidia_drm
    modprobe -r nvidia_modeset
    modprobe -r drm_kms_helper
    modprobe -r nvidia
    modprobe -r i2c_nvidia_gpu
    modprobe -r drm
    echo 'blacklist nvidia' > /etc/modprobe.d/blacklist.conf
    echo 1 > /sys/class/vtconsole/vtcon0/bind
    sleep 1
    echo '0000:01.00.0' /sys/bus/pci/drivers/nouveau/bind
    sleep 1
    systemctl restart sddm
fi
