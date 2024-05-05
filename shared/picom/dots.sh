#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# check if package is installed
if is_arch ; then 
    arch_install picom
else
    is_installed picom
fi

# symlink
symlink $dir/default.conf ~/.config/picom/picom.conf
