#!/usr/bin/env zsh

# install necessary packages
install picom

# symlink configs
symlink $dir/picom.conf ~/.config/picom/picom.conf
