#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# locale
copy_to_root $dir/configs/locale.gen /etc/locale.gen
sudo locale-gen
copy_to_root $dir/configs/locale.conf /etc/locale.conf


# time
sudo ln -sf /usr/share/zoneinfo/America/Campo_Grande /etc/localtime
sudo hwclock --systohc

# system packages
install xorg xorg-xinit mkinitcpio-firmware amd-ucode


# gpu drivers
install mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon libva-mesa-driver lib32-libva-mesa-driver xf86-video-amdgpu



# bluetooth
install bluez bluez-utils

# enable bluetooth service
sudo systemctl enable bluetooth
sudo systemctl start bluetooth



# audio packages
install pipewire pipewire-pulse pipewire-alsa wireplumber

# enable audio services
systemctl --user enable pipewire pipewire-pulse wireplumber
systemctl --user start pipewire pipewire-pulse wireplumber



# arch configs
copy_to_root $dir/configs/pacman.conf /etc/pacman.conf
copy_to_root $dir/configs/makepkg.conf /etc/makepkg.conf
copy_to_root $dir/configs/mkinitcpio.conf /etc/mkinitcpio.conf
copy_to_root $dir/configs/hostname /etc/hostname


# btrfs
install btrfs-progs compsize




