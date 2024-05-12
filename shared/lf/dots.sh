#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# check if package is installed
if is_arch ; then 
    arch_install lf unzip unrar p7zip
else
    is_installed lf unzip unrar 7z
fi

# symlink
symlink $dir/lfrc ~/.config/lf/lfrc
