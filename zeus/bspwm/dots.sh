#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# custom configs
symlink $dir/custom-bspwm.rc ~/.config/bspwm/bspwmrc
symlink $dir/custom-bspwm.rc ~/.config/bspwm/custom-bspwm.rc
symlink $dir/custom-scripts.sh ~/.config/bspwm/custom-scripts.sh