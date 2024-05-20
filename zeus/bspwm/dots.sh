#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# custom scripts
symlink $dir/custom.sh ~/.config/bspwm/scripts/custom.sh