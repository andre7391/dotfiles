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
