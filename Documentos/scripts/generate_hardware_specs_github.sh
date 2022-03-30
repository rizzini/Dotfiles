#!/bin/bash
if [ "$EUID" -ne 0 ]; then
    /usr/bin/echo "Please run as root";
    exit
fi
export LC_ALL=C
fdisk -l | tee '/home/lucas/Documentos/hardware_specs/fdisk -l'
glxinfo -B | tee '/home/lucas/Documentos/hardware_specs/glxinfo -B'
hwinfo | tee '/home/lucas/Documentos/hardware_specs/hwinfo'
inxi -F | tee '/home/lucas/Documentos/hardware_specs/inxi -F'
lsblk | tee '/home/lucas/Documentos/hardware_specs/lsblk'
lscpu | tee '/home/lucas/Documentos/hardware_specs/lscpu'
lshw | tee '/home/lucas/Documentos/hardware_specs/lshw'
lspci -v | tee '/home/lucas/Documentos/hardware_specs/lspci -v'
lsusb -v | tee '/home/lucas/Documentos/hardware_specs/lsusb -v'
vainfo | tee '/home/lucas/Documentos/hardware_specs/vainfo'
vulkaninfo | tee '/home/lucas/Documentos/hardware_specs/vulkaninfo'
btrfs device usage / | tee '/home/lucas/Documentos/hardware_specs/btrfs device usage'
btrfs filesystem df / | tee '/home/lucas/Documentos/hardware_specs/btrfs filesystem df'
btrfs filesystem show | tee '/home/lucas/Documentos/hardware_specs/btrfs filesystem show'
btrfs filesystem usage / | tee '/home/lucas/Documentos/hardware_specs/btrfs filesystem usage'
sudo -u lucas yay -Q | tee '/home/lucas/Documentos/hardware_specs/installed_package_list'
