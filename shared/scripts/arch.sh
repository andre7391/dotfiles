#!/bin/bash

# utils
. shared/scripts/utils.sh

########################################
# Install packages using yay package manager in arch
#
# Arguments:
#   $1 - List of packages to be installed
########################################
install () {

    # vars
    local packages=$@
    local install_packages

    # list installed packages and groups
    if [[ ! $arch_packages ]] ; then
        arch_packages=($(pacman -Q | awk '{print $1}' | sort | uniq ))
        arch_groups=($(pacman -Qg | awk '{print $1}' | sort | uniq ))
    fi

    # check if any package isn`t installed
    for package in ${packages[@]} ; do
        if ! [[ " ${arch_packages[@]} " =~ " $package " || " ${arch_groups[@]} " =~ " $package " ]] ; then
            install_packages=true
        fi
    done

    # check if install is needed
    if [[ $install_packages ]] ; then
        
        # install packages
        yay -S --needed --noconfirm $packages

        log_info "packages installed successfully ${cyan}[$packages]${normal}"
    fi
}