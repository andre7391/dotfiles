#!/usr/bin/env zsh

# install necessary packages
install sxhkd

# symlink configs
symlink $dir/sxhkdrc ~/.config/sxhkd/sxhkdrc

# symlink autostart
symlink $dir/autostart.sh ~/.config/bspwm/autostart/sxhkd.sh

