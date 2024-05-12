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

    # check if its already installed
    if [[ $install_packages ]] ; then
        
        # install packages
        yay -S --needed --noconfirm $packages

        log_info "packages installed successfully ${cyan}[$packages]${normal}"
    fi
}

# ########################################
# # Install package eww in arch
# #
# # Arguments:
# #   None
# ########################################
# arch_install_eww () {


#     # if ! installed eww ; then
#     #     install=T
#     # else
    
#     #     installed-version=$(eww --version | cut -d ' ' -f2)
#     #     last-version=$(git ls-remote --sort=committerdate https://github.com/elkowar/eww refs/tags/* | cut -f2 | tail -1)
        
#     #     if [[ $last-version =~ "*" ]]; then echo "string contains asterisk"; fi
#     # fi


#     # check if eww is installed
#     if ! [[ -x "$(command -v eww)" ]] ; then

#         # install dependencies
#         yay -S --needed --noconfirm gtk3 pango gdk-pixbuf2 cairo glib2 gcc-libs glibc > /dev/null
        
#         # checkout eww repository
#         rm -rf /tmp/eww-install
#         git clone https://github.com/elkowar/eww /tmp/eww-install

#         (
#             # build eww
#             cd /tmp/eww-install
#             cargo build --release --no-default-features --features x11 
#             chmod +x target/release/eww
            
#             # install eww in /usr/bin
#             sudo chown root:root target/release/eww
#             sudo cp target/release/eww /usr/bin
#         )

#         log_info "package installed successfully ${cyan}[eww]${normal}"
#     else
#         log_info "package already installed ${cyan}[eww]${normal}"
#     fi
# }