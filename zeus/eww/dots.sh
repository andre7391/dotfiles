#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# custom configs
symlink $dir/custom.yuck ~/.config/eww/eww.yuck
symlink $dir/custom.yuck ~/.config/eww/custom.yuck

# yay -S cairo gcc-libs gdk-pixbuf2 glib2 glibc gtk3 libdbusmenu-gtk3 pango
