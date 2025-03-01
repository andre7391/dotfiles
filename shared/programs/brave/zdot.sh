#!/usr/bin/env zsh

# install necessary packages
install brave-browser

# symlink
symlink $dir/brave.sh ~/.local/bin/brave


# policies
copy_to_root $dir/policies.json /etc/brave/policies/managed/policies.json


# based on:
# https://github.com/nomadxxxx/fast-brave-debloater/tree/main/policies

# /etc/brave/policies/managed