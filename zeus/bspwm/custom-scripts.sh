#!/usr/bin/env bash

########################################
# Function to configure display using xrandr
#
# Arguments:
#   None
########################################
bspwm_configure_display() {
    current=$(xrandr --current)

    xrandr --auto

    if [[ "$current" = *"DisplayPort-0 connected"* ]]; then
        xrandr --output DisplayPort-0 --primary --mode 1920x1080 --rate 164.97
    fi
}

########################################
# Function to configure input using xinput
#
# Arguments:
#   None
########################################
bspwm_configure_input() {
    xinput set-prop pointer:"Logitech G603" "libinput Accel Profile Enabled" 0 1 0
}



########################################
# Run startup programs
#
# Arguments:
#   None
########################################
bspwm_custom_startup() {
    bspwm_configure_display &
}
