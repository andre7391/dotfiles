#!/usr/bin/env zsh

# install necessary packages
install --quiet gnome-themes-extra

# theme
symlink $dir/catppuccin-macchiato ~/.themes/catppuccin-macchiato
symlink $dir/catppuccin-mocha ~/.themes/catppuccin-mocha

# cursor
symlink $dir/catppuccin-cursor ~/.icons/catppuccin-cursor

# configs
symlink $dir/configs/gtk2.conf ~/.gtkrc-2.0
symlink $dir/configs/gtk3.conf ~/.config/gtk-3.0/settings.ini
symlink $dir/configs/xresources ~/.Xresources


