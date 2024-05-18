#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# system packages
arch_install xorg xorg-xinit mkinitcpio-firmware

# cpu
arch_install amd-ucode

# gpu
arch_install mesa xf86-video-amdgpu vulkan-radeon libva-mesa-driver


# configs
copy_to_root $dir/pacman.conf /etc/pacman.conf
copy_to_root $dir/makepkg.conf /etc/makepkg.conf
copy_to_root $dir/mkinitcpio.conf /etc/mkinitcpio.conf
