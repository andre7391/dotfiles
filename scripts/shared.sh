#!/bin/bash

source $(dirname ${BASH_SOURCE})/utils.sh

########################################
# Function to symlink all shared configs at user home
#
# Arguments:
#   None
########################################
shared::symlink_home() {

    echo -e "\n:: starting symlink home"

    # bspwm
    utils::symlink shared/bspwm/default-bspwm.rc ~/.config/bspwm/bspwmrc
    utils::symlink shared/bspwm/default-bspwm.rc ~/.config/bspwm/default-bspwm.rc
    utils::symlink shared/bspwm/default-sxhkd.rc ~/.config/bspwm/default-sxhkd.rc
    utils::symlink shared/bspwm/default.sh ~/.config/bspwm/default.sh

    # i3wm
    utils::symlink shared/i3/default.conf ~/.config/i3/config
    utils::symlink shared/i3/default.conf ~/.config/i3/default.conf
    utils::symlink shared/i3/default.sh ~/.config/i3//default.sh

    # picom
    utils::symlink shared/picom/default.conf ~/.config/picom/picom.conf

    # kitty
    utils::symlink shared/kitty/default.conf ~/.config/kitty/kitty.conf

    # alacritty
    utils::symlink shared/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml

    # eww
    utils::symlink shared/eww/default.yuck ~/.config/eww/eww.yuck
    utils::symlink shared/eww/default.scss ~/.config/eww/eww.scss
    utils::symlink shared/eww/default.yuck ~/.config/eww/default.yuck
    utils::symlink shared/eww/default.scss ~/.config/eww/default.scss
    utils::symlink shared/eww/scripts ~/.config/eww/scripts

    # xinit
    utils::symlink shared/xinit/.xinitrc ~/.xinitrc

    # utils::symlink config/.profile ~/.profile




    echo -e ":: finished common symlinks\n"

}

########################################
# Function to install fonts at user home
#
# Arguments:
#   None
########################################
shared::appearance_fonts() {
  
    echo -e "\n:: starting shared fonts"

    mkdir -p ~/.local/share/fonts/shared

    # verify if has changes in fonts
    if [[ $(diff -qr shared/appearance/fonts ~/.local/share/fonts/shared | grep -v uuid) ]] ; then

        cp -r shared/appearance/fonts/* ~/.local/share/fonts/shared 
        sudo fc-cache -f -v >> /dev/null
        echo "fonts successfully installed at: [$HOME/.local/share/fonts]"
        
    else
        echo "fonts already installed at: [$HOME/.local/share/fonts]"
    fi

    echo -e ":: finished shared fonts\n"
    
}

shared::appearance() {

    # flavous
    utils::symlink shared/appearance/flavours ~/.config/flavours

    # wallpapers
    utils::symlink shared/appearance/wallpapers ~/.config/wallpapers

    # gtk
    utils::symlink shared/appearance/gtk ~/.themes
    utils::symlink shared/appearance/gtk/gtk2 ~/.gtkrc-2.0
    utils::symlink shared/appearance/gtk/gtk3 ~/.config/gtk-3.0/settings.ini
    utils::symlink shared/appearance/gtk/xsettings ~/.config/xsettingsd/xsettingsd.conf

    # fonts
    shared::appearance_fonts
}

########################################
# Function to configure udisks2 and mounting point
#
# Arguments:
#   None
########################################
common::udisks2() {

    echo -e "\n:: starting udisks2 config"

    common::copy_to_root udisks2/99-udisks2.rules /etc/udev/rules.d/99-udisks2.rules
    #common::copy_to_root udisks2/media.conf /etc/tmpfiles.d/media.conf

    echo -e ":: finished udisks2 configs\n"
}
