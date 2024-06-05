#!/usr/bin/env zsh

# install and enable networkmanager
install networkmanager
systemctl_enable NetworkManager

# hostname
copy_to_root $dir/hostname /etc/hostname

