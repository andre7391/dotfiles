#!/usr/bin/env zsh

########################################
# Declare global variables / cache files
#
# Arguments:
#   None
########################################

# associative array to translate arch pakcages names
typeset -A arch_packages=( 
    [bspwm]=bspwm-git
    [sxhkd]=sxhkd-git
    [xinit]=xorg-xinit
    [xinput]=xorg-xinput
    [xrandr]=xorg-xrandr 
)

# list with all installed arch packages
typeset -a installed_packages=($( { pacman -Q ; pacman -Qg ; } | awk '{print $1}' | sort | uniq ))


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