#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# install necessary packages
install rofi

# symlink
symlink $dir/config.rasi ~/.config/rofi/config.rasi
