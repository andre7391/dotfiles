#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# system packages
install xorg xorg-xinit mkinitcpio-firmware amd-ucode

# gpu drivers
install mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon libva-mesa-driver lib32-libva-mesa-driver xf86-video-amdgpu

# bluetooth
install bluez bluez-utils

# enable bluetooth service
systemctl enable bluetooth
systemctl start bluetooth

# audio packages
install pipewire pipewire-pulse pipewire-alsa wireplumber

# enable audio services
systemctl --user enable pipewire pipewire-pulse wireplumber
systemctl --user start pipewire pipewire-pulse wireplumber

# arch configs
copy_to_root $dir/configs/pacman.conf /etc/pacman.conf
copy_to_root $dir/configs/makepkg.conf /etc/makepkg.conf
copy_to_root $dir/configs/mkinitcpio.conf /etc/mkinitcpio.conf
