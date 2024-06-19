#!/usr/bin/env zsh

# system
install linux linux-firmware base base-devel sudo rust mkinitcpio-firmware amd-ucode

# btrfs
install btrfs-progs

# xorg
install xorg-server

# gpu
install mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon libva-mesa-driver lib32-libva-mesa-driver xf86-video-amdgpu

