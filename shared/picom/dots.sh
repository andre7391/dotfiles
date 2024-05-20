#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# install necessary packages
install picom

# symlink
symlink $dir/picom.conf ~/.config/picom/picom.conf
