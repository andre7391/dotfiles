#!/usr/bin/env zsh

# install necessary packages
install xsecurelock xss-lock

# symlink autostart
symlink $dir/autostart.sh ~/.config/bspwm/autostart/xsecurelock.sh
