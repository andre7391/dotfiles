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
subscribe_bspc() {

    # kill previous subscribe
    pkill bspc
    sleep 0.1

    # subscribe focus
    bspc subscribe node_focus desktop_focus | while read -r _ ; do
        ~/.config/eww/utilities.sh update_window_title
    done &
    
    # subscribe workspaces changes
    bspc subscribe desktop node_transfer | while read -r _ ; do
        ~/.config/eww/utilities.sh update_workspaces
    done &

    # subscribe state changes
    bspc subscribe node_state | while read -r _ _ _ bspc_node bspc_state bspc_status; do
        if [[ $bspc_state == "floating" ]]; then
            case "$bspc_status" in
                off) 
                    xprop -id $bspc_node -remove PICOM_SHADOW
                    ;;
                on) 
                    xprop -id $bspc_node -f PICOM_SHADOW 32c -set PICOM_SHADOW 1
                    ;;
            esac
        fi
    done &

    # current time
    local bspwm_time=$(date +%s%3N)
    
    # save time in cache
    mkdir -p ~/.cache/bspwm
    printf "%s" "$bspwm_time" > ~/.cache/bspwm/time

    while [[ $bspwm_time == $(<~/.cache/bspwm/time) ]]; do
        sleep 2
        ~/.config/eww/utilities.sh update_window_title
        ~/.config/eww/utilities.sh update_workspaces
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
    done
}
