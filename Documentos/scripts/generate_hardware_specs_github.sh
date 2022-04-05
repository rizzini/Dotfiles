#!/bin/bash
if [ "$EUID" -ne 0 ]; then
    /usr/bin/echo "Root needed";
    exit
fi
export LC_ALL=C
/usr/bin/fdisk -l | /usr/bin/tee '/home/lucas/Documentos/hardware_specs/fdisk -l'
/usr/bin/glxinfo -B | /usr/bin/tee '/home/lucas/Documentos/hardware_specs/glxinfo -B'
/usr/bin/hwinfo | /usr/bin/tee '/home/lucas/Documentos/hardware_specs/hwinfo'
/usr/bin/inxi -F | /usr/bin/tee '/home/lucas/Documentos/hardware_specs/inxi -F'
/usr/bin/lsblk | /usr/bin/tee '/home/lucas/Documentos/hardware_specs/lsblk'
/usr/bin/lscpu | /usr/bin/tee '/home/lucas/Documentos/hardware_specs/lscpu'
/usr/bin/lshw | /usr/bin/tee '/home/lucas/Documentos/hardware_specs/lshw'
/usr/bin/lspci -v | /usr/bin/tee '/home/lucas/Documentos/hardware_specs/lspci -v'
/usr/bin/lsusb -v | /usr/bin/tee '/home/lucas/Documentos/hardware_specs/lsusb -v'
/usr/bin/vainfo | /usr/bin/tee '/home/lucas/Documentos/hardware_specs/vainfo'
/usr/bin/vulkaninfo | /usr/bin/tee '/home/lucas/Documentos/hardware_specs/vulkaninfo'
/usr/bin/btrfs device usage / | /usr/bin/tee '/home/lucas/Documentos/hardware_specs/btrfs device usage'
/usr/bin/btrfs filesystem df / | /usr/bin/tee '/home/lucas/Documentos/hardware_specs/btrfs filesystem df'
/usr/bin/btrfs filesystem show | /usr/bin/tee '/home/lucas/Documentos/hardware_specs/btrfs filesystem show'
/usr/bin/btrfs filesystem usage / | /usr/bin/tee '/home/lucas/Documentos/hardware_specs/btrfs filesystem usage'
/usr/bin/sudo -u lucas /usr/bin/yay -Q | /usr/bin/tee '/home/lucas/Documentos/hardware_specs/installed_package_list'
/usr/bin/pacman -Qqem | /usr/bin/tee '/home/lucas/Documentos/hardware_specs/installed_AUR_package_list'
/usr/bin/mount | /usr/bin/tee '/home/lucas/Documentos/hardware_specs/mount'
