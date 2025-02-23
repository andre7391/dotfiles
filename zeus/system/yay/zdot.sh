#!/usr/bin/env zsh

# configure chaotic aur repo
if ! [[ -f /etc/pacman.d/chaotic-mirrorlist ]] ; then
    sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
    sudo pacman-key --lsign-key 3056513887B78AEB
    sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
    sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
fi 

install chaotic-keyring chaotic-mirrorlist


# pacman configs
copy_to_root $dir/pacman.conf /etc/pacman.conf
copy_to_root $dir/makepkg.conf /etc/makepkg.conf
copy_to_root $dir/mkinitcpio.conf /etc/mkinitcpio.conf

# yay
install yay