#!/bin/bash

# utils
. shared/scripts/utils.sh

########################################
# Check if system is arch linux
#
# Arguments:
#   None
########################################
is_arch() {
    [[ -f "/etc/arch-release" ]]
}


########################################
# Install package using yay package manager in arch
#
# Arguments:
#   $1 - Command to execute the program / app
#   $2 - (Optional) Package name at arch/aur repository
########################################
arch_install () {
    local command=$1
    local package=$2
    
    # assumes command as package name
    if ! [[ $package ]] ; then 
        local package=$command
    fi 

    # check if its already installed
    if ! [[ -x "$(command -v $command)" ]] ; then
        
        # install the package
        yay -S --needed --noconfirm $package > /dev/null

        log_info "package installed successfully ${cyan}[$package]${normal}"
    else
        log_info "package already installed ${cyan}[$package]${normal}"
    fi
}

########################################
# Install package eww in arch
#
# Arguments:
#   None
########################################
arch_install_eww () {


    # if ! installed eww ; then
    #     install=T
    # else
    
    #     installed-version=$(eww --version | cut -d ' ' -f2)
    #     last-version=$(git ls-remote --sort=committerdate https://github.com/elkowar/eww refs/tags/* | cut -f2 | tail -1)
        
    #     if [[ $last-version =~ "*" ]]; then echo "string contains asterisk"; fi
    # fi


    # check if eww is installed
    if ! [[ -x "$(command -v eww)" ]] ; then

        # install dependencies
        yay -S --needed --noconfirm gtk3 pango gdk-pixbuf2 cairo glib2 gcc-libs glibc > /dev/null
        
        # checkout eww repository
        rm -rf /tmp/eww-install
        git clone https://github.com/elkowar/eww /tmp/eww-install

        (
            # build eww
            cd /tmp/eww-install
            cargo build --release --no-default-features --features x11 
            chmod +x target/release/eww
            
            # install eww in /usr/bin
            sudo chown root:root target/release/eww
            sudo cp target/release/eww /usr/bin
        )

        log_info "package installed successfully ${cyan}[eww]${normal}"
    else
        log_info "package already installed ${cyan}[eww]${normal}"
    fi
}