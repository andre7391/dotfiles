#!/bin/bash

source $(dirname ${BASH_SOURCE})/arch.sh
source $(dirname ${BASH_SOURCE})/utils.sh
source $(dirname ${BASH_SOURCE})/shared.sh

########################################
# Install dotfiles to host hades (ubuntu linux)
#
# Arguments:
#   None
########################################
hades() {

     # common symlinks
    common.symlink.home


    # install-fonts
    common.install.fonts



    # i3
    common.symlink hades/i3/custom.conf ~/.config/i3/config
    common.symlink hades/i3/custom.conf ~/.config/i3/custom.conf
    common.symlink hades/i3/custom.sh ~/.config/i3/custom.sh
}

########################################
# Install dotfiles to host zeus (arch linux)
#
# Arguments:
#   None
########################################
install::zeus() {

    # ip link set wlan0 up
    
    # install-fonts
    shared::symlink_fonts

    # shared packages
    arch::install_shared

    # common symlinks
    common.symlink.home

    # i3
    common.symlink zeus/i3/custom.conf ~/.config/i3/config
    common.symlink zeus/i3/custom.conf ~/.config/i3/custom.conf
    common.symlink zeus/i3/custom.sh ~/.config/i3/custom.sh
}

# execute a function passsed as argument (ex: setup shared_symlink)
"$@"



# # i3
# symlink i3/config ~/.config/i3/config

# # picom
# symlink picom/picom.conf ~/.config/picom/picom.conf

# # alacritty
# symlink alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml

# # eww 
# symlink eww ~/.config/eww

# # wallpapers
# #symlink wallpapers  

