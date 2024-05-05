#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# check if package is installed
if is_arch ; then 
    arch_install xsettingsd
else
    is_installed xsettingsd
fi

# theme
symlink $dir/catppuccin-macchiato ~/.themes/catppuccin-macchiato
symlink $dir/catppuccin-mocha ~/.themes/catppuccin-mocha

# cursor
symlink $dir/catppuccin-cursor ~/.icons/catppuccin-cursor

# configs
symlink $dir/gtk2.conf ~/.gtkrc-2.0
symlink $dir/gtk3.conf ~/.config/gtk-3.0/settings.ini
symlink $dir/xsettings.conf ~/.config/xsettingsd/xsettingsd.conf
symlink $dir/xresources ~/.Xresources


