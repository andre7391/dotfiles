#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# check if package is installed
is_installed wallust

# wallpapers
symlink $dir/wallust.toml ~/.config/wallust/wallust.toml
symlink $dir/templates ~/.config/wallust/templates

