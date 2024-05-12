#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# arch_install reflector
# reflector --country ''

# pacman
copy_to_root $dir/pacman.conf /etc/pacman.conf

# makepkg
copy_to_root $dir/makepkg.conf /etc/makepkg.conf
