#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# install necessary packages
install kitty

# symlink configs
symlink $dir/kitty.conf ~/.config/kitty/kitty.conf

