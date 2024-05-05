#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# check if package is installed
if is_arch ; then 
    arch_install_eww
else
    is_installed eww
fi

# symlink configs
symlink $dir/default.yuck ~/.config/eww/eww.yuck
symlink $dir/default.scss ~/.config/eww/eww.scss
symlink $dir/default.yuck ~/.config/eww/default.yuck
symlink $dir/default.scss ~/.config/eww/default.scss
symlink $dir/default.sh ~/.config/eww/default.sh
# symlink $dir/scripts ~/.config/eww/scripts