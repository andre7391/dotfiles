#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# install necessary packages
install visual-studio-code-bin

# settings
symlink $dir/settings.json ~/.config/Code/User/settings.json

# backup extensions
code --list-extensions > $dir/extensions