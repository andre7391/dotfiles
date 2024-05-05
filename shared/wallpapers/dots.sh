#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# wallpapers
symlink $dir/images ~/.config/wallpapers

