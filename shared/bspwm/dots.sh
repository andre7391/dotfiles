#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# check if packages are installed
if is_arch ; then 
    arch_install bspwm
    arch_install sxhkd
    arch_install xclip
    arch_install xdo
    arch_install numlockx
    arch_install xorg-xinput
    arch_install feh
    arch_install xorg-xrandr
else
    is_installed bspwm
    is_installed sxhkd
    is_installed xclip
    is_installed xdo
    is_installed numlockx
    is_installed xinput
    is_installed feh
    is_installed xrandr
fi

# symlink
symlink $dir/default-bspwm.rc ~/.config/bspwm/bspwmrc
symlink $dir/default-bspwm.rc ~/.config/bspwm/default-bspwm.rc
symlink $dir/default-sxhkd.rc ~/.config/bspwm/default-sxhkd.rc
symlink $dir/default-scripts.sh ~/.config/bspwm/default-scripts.sh
symlink $dir/default-xinit.rc ~/.xinitrc


