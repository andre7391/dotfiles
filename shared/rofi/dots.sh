#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# check if package is installed
if is_arch ; then 
    arch_install rofi
else
    is_installed rofi
fi

# symlink
symlink $dir/default.rasi ~/.config/rofi/config.rasi
