#!/usr/bin/env zsh

# install necessary packages
install bspwm xinit xinput xrandr xdo xsetroot numlockx feh flameshot

# symlink configs
symlink $dir/bspwmrc ~/.config/bspwm/bspwmrc
symlink $dir/xinitrc ~/.xinitrc
symlink $dir/utilities.sh ~/.config/bspwm/utilities.sh


