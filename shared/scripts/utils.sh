#!/usr/bin/env bash

# styles
bold=$(tput bold)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
pink=$(tput setaf 5)
cyan=$(tput setaf 6)
normal=$(tput sgr0)

banner() {
     printf "\n\n"
     printf "%s\n" "${bold}${green}:: ${yellow}$1 ${bold}${green}::${normal}"
}

log_info() {
    local message=$1
    local script=$2

    if [[ $script ]] ; then
        local prefix="${bold}${blue}$script ${green}::${normal}"
    elif [[ ${BASH_SOURCE[2]} ]] ; then
        local prefix="${bold}${blue}${BASH_SOURCE[2]} ${green}::${normal}"
    fi
    printf "%s\n" " $prefix $message"
}

log_error() {
    if [[ ${BASH_SOURCE[2]} ]] ; then
        local prefix="${bold}${red}${BASH_SOURCE[2]} ${green}::${normal}"
    else 
        local prefix="${bold}${red}error ${green}${bold}::${normal}"
    fi
    printf "%s\n" " $prefix $1"
}


########################################
# Verify if a package / app is installed
#
# Arguments:
#   $1 - Command to execute the program / app
########################################
is_installed() {


    if ! [[ -x "$(command -v $1)" ]] ; then
        # log error
        log_error "package ${pink}[$1]${normal} is not installed"

        return 1
    fi
}



########################################
# Helper to symlink files e make automatic backups
#
# Arguments:
#   $1 - File or folder to be symlinked
#   $2 - Destiny where the synlink will be created
########################################
symlink() {

    # stop if source file / folder doesnt exists
    if ! [[ -f $1 ]] && ! [[ -d $1 ]] ; then
        log_error "source file / folder doesnt exists ${pink}[$1]${normal}"
        return 1
    fi

    # if  [[ -d $1 ]] ; then
    #     find $1 -type f | xargs -L 1 -I file symlink "aa bfile"
    #     files=$(find $1 -type f )
    #     # for i in $(find . -name \*.txt); do 
    #     #     process "$i"
    #     # done
    # fi

    # create destiny folder
    mkdir -p $2 2> /dev/null

    # remove file / folder and create symlink
    rm -r $2
    ln -s $(realpath -s $1) $2
    
    log_info "symlink created from ${cyan}[$1]${normal} to ${cyan}[$2]${normal}"
}

########################################
# Copy a file to a root owned folder and change file ownership
#
# Arguments:
#   $1 - File or folder to be copied
#   $2 - Destiny where the copy will be created
########################################
copy_to_root() {
    
    if ! diff -qr $1 $2 &> /dev/null ; then
        sudo chattr -i $2 2> /dev/null
        sudo cp -r $1 $2
        sudo chown -R root:root $2
        log_info "file copied from ${cyan}[$1]${normal} to ${cyan}[$2]${normal}"
    else
        log_info "file already exists ${cyan}[$2]${normal}"
        return 1
    fi
}

########################################
# Find and source all dots scripts (dots.sh) in a directory
#
# Arguments:
#   $1 - Directory with dots to be executed
########################################
dots() {
    
    # find all scripts in folder
    scripts=($(find $1/* -name dots.sh -type f))

    for script in ${scripts[@]} ; do

        # check to avoid recursion
        caller=${BASH_SOURCE[1]}
        if [[ $script != $caller ]] ; then

            # source the script
            . $script
        fi
    done
}










########################################
# Function to install fonts in the system
#
# Arguments:
#   None
########################################
common.install.fonts() {

    echo -e "\n:: starting common fonts"

    # verify if has changes in fonts
    if [[ $(diff -qr fonts/ /usr/share/fonts/common/ | grep -v uuid) ]] ; then
        sudo rm -rf /usr/share/fonts/common
        sudo mkdir -p /usr/share/fonts/common
        sudo cp -r fonts/* /usr/share/fonts/common
        sudo chown -R root:root /usr/share/fonts/common
        sudo fc-cache -f -v >> /dev/null
        echo "fonts successfully installed at: [/usr/share/fonts/common]"
        
    else
        echo "fonts already installed at: [/usr/share/fonts/common]"
    fi

    echo -e ":: finished common fonts\n"
}


########################################
# Function to symlink all common configs at user home
#
# Arguments:
#   None
########################################
common.symlink.home() {

    echo -e "\n:: starting symlink home"

    # i3wm
    common.symlink shared/i3/default.conf ~/.config/i3/config
    common.symlink shared/i3/default.conf ~/.config/i3/default.conf
    common.symlink shared/i3/default.sh ~/.config/i3//default.sh

    # picom
    common.symlink shared/picom/default.conf ~/.config/picom/picom.conf

    # kitty
    common.symlink shared/kitty/default.conf ~/.config/kitty/kitty.conf

    # eww
    common.symlink shared/eww ~/.config/eww


    common.symlink shared/wallpapers ~/.config/wallpapers
    
    # xinit
    common.symlink shared/xinit/.xinitrc ~/.xinitrc

    common.symlink shared/flavours ~/.config/flavours
    
    common.symlink config/.profile ~/.profile


    common.symlink shared/themes ~/.themes
    common.symlink shared/themes/gtk2 ~/.gtkrc-2.0
    common.symlink shared/themes/gtk3 ~/.config/gtk-3.0/settings.ini
    common.symlink shared/themes/xsettings ~/.config/xsettingsd/xsettingsd.conf

    echo -e ":: finished common symlinks\n"

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
