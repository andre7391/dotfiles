#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# settings
symlink $dir/settings.json ~/.config/Code/User/settings.json

# backup extensions
code --list-extensions > $dir/extensions