#!/usr/bin/env zsh

# symlink
symlink $dir/flags.conf ~/.config/brave/flags.conf

# policies
copy_to_root $dir/policies.json /etc/brave/policies/managed/policies.json

# based on:
# https://github.com/nomadxxxx/fast-brave-debloater/tree/main/policies
