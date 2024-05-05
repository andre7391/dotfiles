#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# custom configs
symlink $dir/custom.yuck ~/.config/eww/eww.yuck
symlink $dir/custom.yuck ~/.config/eww/custom.yuck

