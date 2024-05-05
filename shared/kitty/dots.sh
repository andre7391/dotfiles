#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# check if package is installed
if is_arch ; then 
    arch_install kitty
else
    is_installed kitty
fi

# symlink configs
symlink $dir/default.conf ~/.config/kitty/kitty.conf

