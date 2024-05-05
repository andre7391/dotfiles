#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# check if package is installed
if is_arch ; then 
    arch_install lf
else
    is_installed lf
fi

# symlink
symlink $dir/lfrc ~/.config/lf/lfrc
