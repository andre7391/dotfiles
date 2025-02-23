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
    [xsetroot]=xorg-xsetroot 
    [xwininfo]=xorg-xwininfo 
)

# list with all installed arch packages
typeset -a query_installed_packages=($( pacman -Qe | awk '{print $1}' | sort | uniq ))


# file with all packages installed by current execution
typeset current_installed_packages_file=~/.cache/zdots/current_installed_packages
mkdir -p $(dirname $current_installed_packages_file)
printf "" > $current_installed_packages_file


########################################
# Install packages using yay package manager in arch
#
# Arguments:
#   $@ - List of packages to be installed
########################################
install() {

    # parse args
    parse_args "$@"

    # vars
    local packages=($args)
    local packages_to_install=()
    
    # check packages not installed
    for package in $packages ; do
        # translate package to arch name
        if [[ -n $arch_packages[$package] ]] ; then
            package=$arch_packages[$package]
        fi

        # check if package is installed
        if ! [[ " ${query_installed_packages[@]} " =~ " $package " ]] ; then
            packages_to_install=( $packages_to_install $package )
        fi

        # add to installed packages at current execution
        printf "%s\n" $package >> $current_installed_packages_file
    done

    # check if install is needed
    if [[ -n $packages_to_install ]] ; then
        
        # update current packages 
        yay
        
        # install packages
        yay -S --needed --noconfirm $packages_to_install

        # mark packages as explicit installed
        yay -D --asexplicit $packages_to_install

        log_info "packages installed successfully ${cyan}[$packages_to_install]${normal}"
    fi
}

clean_packages() {

    # list of all packages installed by current execution
    local current_installed_packages=($(cat $current_installed_packages_file))

    # remove all packages not explicity installed in this execution
    for package in ${query_installed_packages[@]} ; do
        if ! [[ " ${current_installed_packages[@]} " =~ " $package " ]] ; then
            # yay -Rus --noconfirm $package
            log_info "removed unused package ${pink}[$package]${normal}"
        fi 
    done

    # remove unused dependencies
    yay -Yc --noconfirm

    # clean package cache
    # yay -Sc --noconfirm

    log_info "packages ${cyan}[cleaned]${normal}"
}