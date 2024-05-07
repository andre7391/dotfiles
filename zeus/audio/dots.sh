#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# audio packages
arch_install pipewire
arch_install wireplumber
arch_install pipewire-pulse
arch_install pipewire-alsa

# enable services
systemctl --user enable pipewire
systemctl --user enable pipewire-pulse
systemctl --user enable wireplumber
systemctl --user start pipewire
systemctl --user start pipewire-pulse
systemctl --user start wireplumber
