#!/usr/bin/env zsh

########################################
# Declare global variables / cache files
#
# Arguments:
#   None
#######################################

# file with all executed zdots scripts
typeset executed_zdots_file=~/.cache/zdots/executed_zdots
mkdir -p $(dirname $executed_zdots_file)
printf "" > $executed_zdots_file

# file with all symlinks created by symlink utility
typeset created_symlinks_file=~/.cache/zdots/created_symlinks
mkdir -p $(dirname $created_symlinks_file)
printf "" > $created_symlinks_file


########################################
# Global variables used to style logs
#
# Arguments:
#   None
#######################################
typeset bold=$(tput bold)
typeset red=$(tput setaf 1)
typeset green=$(tput setaf 2)
typeset yellow=$(tput setaf 3)
typeset blue=$(tput setaf 4)
typeset pink=$(tput setaf 5)
typeset cyan=$(tput setaf 6)
typeset normal=$(tput sgr0)


########################################
# Show a banner
#
# Arguments:
#   $1 - Message to be displayed in the banner
########################################
banner() {
     printf "\n\n" >&2
     printf "%s\n" "${bold}${green}:: ${yellow}$1 ${bold}${green}::${normal}" >&2
}

########################################
# Log an info message
#
# Arguments:
#   $1 - Message to be displayed
########################################
log_info() {
    printf "%s\n" " ${bold}${blue}$file ${green}::${normal} $1" >&2
}

########################################
# Log an error message
#
# Arguments:
#   $1 - Message to be displayed
########################################
log_error() {
    printf "%s\n" " ${bold}${red}$file ${green}::${normal} $1" >&2
}

########################################
# Find and source all zdots scripts (zdot.sh) in a directory
#
# Arguments:
#   $1 - Directory with dots to be executed
########################################
zdots() {

    # find all scripts in folder
    local scripts=($(find $1/* -name zdot.sh -type f))

    for script in ${scripts[@]} ; do
        # source the script if it wasn't already executed
        local executed_zdots=($(cat $executed_zdots_file))
        if ! [[ " ${executed_zdots[@]} " =~ " $script " ]] ; then
            (
                file=$script
                dir=$(dirname $script)
                . $script
            )
            log_info "finished ${cyan}[$script]${normal}"
            printf "%s\n" "$script" >> $executed_zdots_file
        fi
    done

    # return success
    return 0 
}

########################################
# Parse arguments used by zdots functions 
#
# Arguments:
#   $@ - All arguments received
########################################
parse_args() {

    # reset values
    unset quiet
    unset user

    # parse args
    zparseopts -D -F -K -- \
        -quiet=quiet \
        -user=user \
        {f,-filename}:=arg_filename 

    args=($@)
}

########################################
# Verify if a package / app is installed
#
# Arguments:
#   --quiet - When it doesn't need to print the output
#   $@ - List of commands to execute the program / app
########################################
is_installed() {

    # parse args
    parse_args "$@"

    # vars
    local packages=($args)
    local return=0

    for package in ${packages[@]} ; do
        if ! [[ -x "$(command -v $package)" ]] ; then
            
            if ! [[ -n $quiet ]] ; then
                # log error
                log_error "package ${pink}[$package]${normal} is not installed"
            fi

            return=1
        fi
    done

    return $return
}

########################################
# Placeholder to system specific install method
#
# Arguments:
#   $@ - Command to execute the program / app
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

    # add destination to list of symlinks created
    printf "%s\n" "$(realpath --no-symlinks $2)" >> $created_symlinks_file

    # stop if symlink already exists
    if [[ -e $2 && $(realpath $2) == $(realpath $1) ]] ; then
        return 0
    fi 

    # create destiny folder
    mkdir -p $2 2> /dev/null

    # remove file / folder and create symlink
    rm -r $2
    ln -s $(realpath $1) $2
    
 

    log_info "symlink created from ${cyan}[$1]${normal} to ${cyan}[$2]${normal}"
}


########################################
# Helper to remove broken / unused symlink files at home
#
# Arguments:
#   $1 - Dotfiles folder
########################################
clean_symlinks() {

    # args
    local dotfiles_dir=$(readlink -f $1)

    # list and remove all broken symlinks
    local broken_symlinks=($(find ~ -xtype l | grep -v .mozilla))
    for symlink in ${broken_symlinks[@]} ; do
        log_info "removed broken symlink ${pink}[$symlink]${normal} targeting ${pink}[$(readlink $symlink)]${normal}"
        rm $symlink
    done

    # list all symlinks targeting dotfiles directory
    local dotfiles_symlinks=($(find ~ -lname "$dotfiles_dir*"))

    # list of all symlinks created by symlink function
    local created_symlinks=($(cat $created_symlinks_file))

    # remove all symlinks that weren't created by this execution
    for symlink in ${dotfiles_symlinks[@]} ; do
        if ! [[ " ${created_symlinks[@]} " =~ " $symlink " ]] ; then
            log_info "removed unused symlink ${pink}[$symlink]${normal} targeting ${pink}[$(readlink $symlink)]${normal}"
            rm $symlink
        fi 
    done

    log_info "symlinks ${cyan}[cleaned]${normal}"
}

########################################
# Copy a file/folder to a root owned folder and change file ownership
#
# Arguments:
#   $1 - File or folder to be copied
#   $2 - Destiny where the copy will be created
########################################
copy_to_root() {
    
    if ! sudo diff -qr $1 $2 &> /dev/null ; then
        sudo chattr -i $2 2> /dev/null
        sudo cp -r $1 $2
        log_info "file copied from ${cyan}[$1]${normal} to ${cyan}[$2]${normal}"
    else
        return 1
    fi
}

########################################
# Enable and start a systemctl service
#
# Arguments:
#   --user - Flag indicating a service
#   $@ - Services to enable / start
########################################
systemctl_enable() {
    
    # parse args
    parse_args "$@"
    
    # vars
    local services=($args)
    
    # enable / start all services
    for service in ${services[@]} ; do

        # enable service
        if ! systemctl $user -q is-enabled $service ; then
            if [[ -n $user ]] ; then
                systemctl $user --now enable $service
            else 
                sudo systemctl --now enable $service
            fi
            log_info "service ${cyan}[$service]${normal} enabled"
        fi

        # start service
        if ! systemctl $user -q is-active $service ; then
            if [[ -n $user ]] ; then
                systemctl $user enable $service
                systemctl $user start $service
            else 
                sudo systemctl enable $service
                sudo systemctl start $service
            fi
            log_info "service ${cyan}[$service]${normal} started"
        fi
    done
}

