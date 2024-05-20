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

########################################
# Show a banner
#
# Arguments:
#   $1 - Message to be displayed in the banner
########################################
banner() {
     printf "\n\n"
     printf "%s\n" "${bold}${green}:: ${yellow}$1 ${bold}${green}::${normal}"
}

########################################
# Log an info message
#
# Arguments:
#   $1 - Message to be displayed
#   $2 - (Optional) Path that generated the message
########################################
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

########################################
# Log an error message
#
# Arguments:
#   $1 - Message to be displayed
########################################
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
#   $1 - List of commands to execute the program / app
########################################
is_installed() {

    # vars
    local packages=$@
    local return=0

    for package in ${packages[@]} ; do
        if ! [[ -x "$(command -v $package)" ]] ; then
            
            # log error
            log_error "package ${pink}[$package]${normal} is not installed"

            return=1
        fi
    done

    return $return
}

########################################
# Placeholder to system specific install method
#
# Arguments:
#   $1 - Command to execute the program / app
########################################
install() {
   is_installed $@
}

########################################
# Helper to symlink files
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

    # stop if symlink already exists
    if [[ -e $2 && $(readlink -f $2) == $(readlink -f $1) ]] ; then
        return 0
    fi 

    # create destiny folder
    mkdir -p $2 2> /dev/null

    # remove file / folder and create symlink
    rm -r $2
    ln -s $(readlink -f $1) $2
    
    log_info "symlink created from ${cyan}[$1]${normal} to ${cyan}[$2]${normal}"
}

########################################
# Copy a file/folder to a root owned folder and change file ownership
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

            log_info "finished ${cyan}[$script]${normal}"
        fi
    done

    # return success
    return 0 
}

########################################
# Check if system is arch linux
#
# Arguments:
#   None
########################################
is_arch() {
    [[ -f "/etc/arch-release" ]]
}
