#!/usr/bin/env zsh

# install necessary packages
install xsettingsd

# symlink config
symlink $dir/xsettingsd.conf ~/.config/xsettingsd/xsettingsd.conf

# symlink autostart
symlink $dir/autostart.sh ~/.config/bspwm/autostart/xsettingsd.sh
