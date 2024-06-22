#!/usr/bin/env zsh

# install required packages
install gtk3 pango gdk-pixbuf2 libdbusmenu-gtk3 cairo glib2 gcc-libs glibc

# custom configs
symlink $dir/custom.yuck ~/.config/eww/custom.yuck
