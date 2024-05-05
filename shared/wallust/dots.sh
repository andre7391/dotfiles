#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# check if package is installed
if is_arch ; then 
    is_installed wallust
else
    is_installed wallust
fi

# wallpapers
symlink $dir/default.toml ~/.config/wallust/wallust.toml
symlink $dir/templates ~/.config/wallust/templates

