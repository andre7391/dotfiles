#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# check if packages are installed
if is_arch ; then 
    arch_install bspwm sxhkd xorg-xinput xorg-xrandr
    arch_install xclip xdo numlockx feh flameshot 
else
    is_installed bspwm sxhkd xinput xrandr
    is_installed xclip xdo numlockx feh flameshot
fi

# symlink
symlink $dir/default-bspwm.rc ~/.config/bspwm/bspwmrc
symlink $dir/default-bspwm.rc ~/.config/bspwm/default-bspwm.rc
symlink $dir/default-sxhkd.rc ~/.config/bspwm/default-sxhkd.rc
symlink $dir/default-scripts.sh ~/.config/bspwm/default-scripts.sh
symlink $dir/default-xinit.rc ~/.xinitrc


