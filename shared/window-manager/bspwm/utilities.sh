#!/usr/bin/env zsh

########################################
# Function to configure bspwm
#
# Arguments:
#   none
########################################
configure_bspwm() {
    # others configs
    bspc config window_gap              4
    bspc config top_padding             32 # bar = 28 + gap
    bspc config border_width            2
    bspc config split_ratio             0.55
    bspc config borderless_monocle      false
    bspc config gapless_monocle         false  
    bspc config pointer_motion_interval 2ms
}


########################################
# Function to create bspwm workspaces
#
# Arguments:
#   none
########################################
configure_workspaces() {
    # workspaces
    workspaces=(1 2 3 4 5 6 7 8 9 S PI PE)

    # current workspaces
    current_workspaces=($(bspc query -D --names))
    for workspace in ${workspaces[@]} ; do
        if [[ ! ${current_workspaces[@]} =~ $workspace ]] ; then
            bspc monitor -d ${workspaces[@]}
            return 0
        fi
    done
}


########################################
# Function to configure keyboard layout / numlock
#
# Arguments:
#   none
########################################
configure_keyboard() {
    setxkbmap -layout us -variant altgr-intl
    numlockx
}


########################################
# Function subscribe and place to focused window above others
#
# Arguments:
#   none
########################################
subscribe_focused() {

    # trap to kill all child process
    trap 'kill $(jobs -p)' EXIT

    # kill previous subscribe
    pkill bspc
    sleep 0.1

    # first print to avoid starting empty
    bspc subscribe | while read -r _ ; do
        bspc node last.local -l normal
        bspc node focused -l above
    done &
}


########################################
# Function to execute scripts
#
# Arguments:
#   none
########################################
autostart() {
    # find all scripts in folder
    local scripts=($(find ~/.config/bspwm/autostart/*))

    for script in ${scripts[@]} ; do
        # source the script
        . $script &
        echo $script
    done
}
