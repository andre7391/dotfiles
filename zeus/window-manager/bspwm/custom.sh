#!/usr/bin/env zsh

########################################
# Configure display using xrandr
########################################
configure_display() {
    current=$(xrandr --current)

    xrandr --auto

    if [[ "$current" = *"DisplayPort-0 connected"* ]]; then
        xrandr --output DisplayPort-0 --primary --mode 1920x1080 --rate 164.97
    fi
}

########################################
# Configure mouse using xinput
########################################
configure_mouse() {
    xinput set-prop pointer:"Logitech G603" "libinput Accel Profile Enabled" 0 1 0
}

########################################
# Start udiskie
########################################
start_udiskie() {
    pkill udiskie
    udiskie
}

########################################
# Run startup programs
########################################
startup() {
    default_startup &
    configure_display &
    configure_mouse &
    start_udiskie &
}
