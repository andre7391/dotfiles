#!/usr/bin/env zsh

# pacman configs
copy_to_root $dir/pacman.conf /etc/pacman.conf
copy_to_root $dir/makepkg.conf /etc/makepkg.conf
copy_to_root $dir/mkinitcpio.conf /etc/mkinitcpio.conf
