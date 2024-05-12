#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# system packages
arch_install xorg xorg-xinit

# cpu
arch_install amd-ucode

# gpu
arch_install mesa xf86-video-amdgpu vulkan-radeon libva-mesa-driver
