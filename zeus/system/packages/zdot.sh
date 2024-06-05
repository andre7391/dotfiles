#!/usr/bin/env zsh

# system
install rust mkinitcpio-firmware amd-ucode 

# btrfs
install btrfs-progs compsize

# xorg
install xorg

# gpu
install mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon libva-mesa-driver lib32-libva-mesa-driver xf86-video-amdgpu

