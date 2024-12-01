#!/usr/bin/env zsh

# install necessary packages
install stalonetray

# symlink config
symlink $dir/stalonetrayrc ~/.config/stalonetrayrc

# symlink autostart
symlink $dir/autostart.sh ~/.config/bspwm/autostart/stalonetray.sh
