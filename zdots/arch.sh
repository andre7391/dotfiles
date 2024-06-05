#!/usr/bin/env zsh

# declare global variables
typeset -A arch_packages
typeset -a installed_packages

########################################
# Load variables used by arch scripts
#
# Arguments:
#   None
########################################
load_vars() {

    # packages names for arch installation
    arch_packages=( 
        [bspwm]=bspwm-git
        [sxhkd]=sxhkd-git
        [xinit]=xorg-xinit
        [xinput]=xorg-xinput
        [xrandr]=xorg-xrandr 
    )

    # installed packages and groups
    installed_packages=($( { pacman -Q ; pacman -Qg ; } | awk '{print $1}' | sort | uniq ))
}

# load vars
load_vars


########################################
# Install packages using yay package manager in arch
#
# Arguments:
#   $@ - List of packages to be installed
########################################
install () {

    # vars
    local packages=($@)
    local install_packages=()
    
    # check packages not installed
    for package in $packages ; do
        # translate package to arch name
        if [[ -n $arch_packages[$package] ]] ; then
            package=$arch_packages[$package]
        fi

        # check if package is installed
        if ! [[ " ${installed_packages[@]} " =~ " $package " ]] ; then
            install_packages=( $install_packages $package )
        fi
    done

    # check if install is needed
    if [[ -n $install_packages ]] ; then
        
        # install packages
        yay -S --needed --noconfirm $install_packages

        log_info "packages installed successfully ${cyan}[$install_packages]${normal}"
    fi
}