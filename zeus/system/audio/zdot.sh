#!/usr/bin/env zsh

# install and enable bluetooth
install bluez bluez-utils
systemctl_enable bluetooth

# install and enable pipewire
install pipewire pipewire-pulse pipewire-alsa wireplumber lib32-pipewire lib32-libpulse lib32-alsa-lib lib32-alsa-plugins 
systemctl_enable --user pipewire pipewire-pulse wireplumber
