#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# install necessary packages
if is_arch ; then 
    install bspwm sxhkd xorg-xinput xorg-xrandr xdo numlockx feh flameshot 
else
    is_installed bspwm sxhkd xinput xrandr xdo numlockx feh flameshot 
fi

# symlink
symlink $dir/configs/bspwmrc ~/.config/bspwm/bspwmrc
symlink $dir/configs/sxhkdrc ~/.config/bspwm/sxhkdrc
symlink $dir/configs/xinitrc ~/.xinitrc
symlink $dir/scripts/default.sh ~/.config/bspwm/scripts/default.sh


