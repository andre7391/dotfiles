#!/usr/bin/env zsh

# install necessary packages
install bspwm sxhkd xinit xinput xrandr xdo numlockx feh flameshot 

# symlink
symlink $dir/configs/bspwmrc ~/.config/bspwm/bspwmrc
symlink $dir/configs/sxhkdrc ~/.config/bspwm/sxhkdrc
symlink $dir/configs/xinitrc ~/.xinitrc
symlink $dir/scripts/default.sh ~/.config/bspwm/scripts/default.sh


