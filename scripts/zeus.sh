#!/bin/bash

source $(dirname ${BASH_SOURCE})/arch.sh
source $(dirname ${BASH_SOURCE})/utils.sh
source $(dirname ${BASH_SOURCE})/shared.sh

########################################
# Function to install all packages used in zeus
#
# Arguments:
#   None
########################################
zeus::install_packages() {

    echo -e "\n:: starting zeus packages"

    # install arch packages
    arch::install xrandr xorg-xrandr
    arch::install picom
    arch::install dmenu
    arch::install dunst
    arch::install nitrogen
    arch::install alacritty
    arch::install thunar
    arch::install rofi
    arch::install feh
    arch::install unzip

    # isntall eww
    arch::install_eww

    echo -e ":: finished zeus packages\n"

}

########################################
# Function to symlink custom zeus configs
#
# Arguments:
#   None
########################################
zeus::symlink() {

    echo -e "\n:: starting zeus symlinks"

    # bspwm
    utils::symlink zeus/bspwm/custom-bspwm.rc ~/.config/bspwm/bspwmrc
    utils::symlink zeus/bspwm/custom-bspwm.rc ~/.config/bspwm/custom-bspwm.rc
    utils::symlink zeus/bspwm/custom.sh ~/.config/bspwm/custom.sh

    # eww
    utils::symlink zeus/eww/custom.yuck ~/.config/eww/eww.yuck
    utils::symlink zeus/eww/custom.yuck ~/.config/eww/custom.yuck

    echo -e ":: finished zeus symlinks\n"

}



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

    # eww
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
zeus::install() {

    # ip link set wlan0 up
    # sudo ip link set wlan0 state UP mode DEFAULT
    
    # appearance
    shared::appearance

    # shared packages
    zeus::install_packages

    # shared symlinks
    shared::symlink_home

    # zeus symlinks
    zeus::symlink
}


zeus::install

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

