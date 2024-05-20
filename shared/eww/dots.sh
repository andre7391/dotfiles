#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# check if package is installed
is_installed eww

# symlink configs
symlink $dir/eww.yuck ~/.config/eww/eww.yuck
symlink $dir/eww.scss ~/.config/eww/eww.scss
symlink $dir/scripts/default.sh ~/.config/eww/scripts/default.sh
