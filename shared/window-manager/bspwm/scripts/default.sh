#!/usr/bin/env zsh

########################################
# Configure workspaces
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
# Configure keyboard configuration
######################################## 
configure_keyboard() {
    setxkbmap -layout us -variant altgr-intl
    numlockx
}


########################################
# Configure bspwm colors
########################################
configure_colors() {
    # load wallust colors
    . ~/.cache/wallust/colors.sh

    # set colors to bspwm
    bspc config normal_border_color "$color10"
    bspc config active_border_color "$color13"
    bspc config focused_border_color "$foreground"
    bspc config presel_feedback_color "$color13"
}


########################################
# Default bspwm configs
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
# Start eww
########################################
start_eww() {
    pkill eww
    eww daemon &> /dev/null
    eww open bar-window &> /dev/null
    sleep 0.1
    xdo below -t $(xdo id -n root) $(xdo id -n eww)
}


########################################
# Start picom
########################################
start_picom() {
    pkill picom
    sleep 0.1
    picom --daemon --config ~/.config/picom/picom.conf 
}


########################################
# Start sxhkd
######################################## 
start_sxhkd() {
    pkill sxhkd
    sxhkd -c ~/.config/bspwm/sxhkdrc
}


########################################
# Change theme based on wallpaper
######################################## 
change_theme() {

    # random wallpaper
    wallpaper=$(shuf -e -n1 ~/.config/wallpapers/*)

    feh --bg-fill $wallpaper
    wallust run -s $wallpaper
    eww reload
    xdo below -t $(xdo id -n root) $(xdo id -n eww)
    kill -SIGUSR1 $(pidof kitty) # reload kitty

    # reload bspwm colors
    bspwm_colors

    # xsettingsd to reload gtk
    pkill xsettingsd
    xsettingsd &
}


########################################
# Run default startup functions
########################################
default_startup() {
    configure_bspwm &
    configure_colors &
    configure_workspaces &
    configure_keyboard &
    start_sxhkd &
    start_eww &
    start_picom &
    change_theme &
}

