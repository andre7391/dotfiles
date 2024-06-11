#!/usr/bin/env zsh

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
# Function to set theme colors to bspwm
#
# Arguments:
#   none
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
# Function to start and configure eww
#
# Arguments:
#   none
########################################
start_eww() {
    pkill eww
    eww daemon &> /dev/null
    eww open bar-window &> /dev/null
    sleep 0.1
    xdo below -t $(xdo id -n root) $(xdo id -n eww)
}


########################################
# Function to start and configure picom
#
# Arguments:
#   none
########################################
start_picom() {
    pkill picom
    sleep 0.1
    picom --daemon --config ~/.config/picom/picom.conf 
}


########################################
# Function to start and configure sxhkd
#
# Arguments:
#   none
#######################################
start_sxhkd() {
    pkill sxhkd
    sxhkd -c ~/.config/bspwm/sxhkdrc
}

########################################
# Function to shuffle and return a random wallpaper
#
# Arguments:
#   none
########################################
random_wallpaper() {
    
    # constants
    readonly wallpapers_cache=~/.cache/wallpapers

    # create dir and files if they dont exists
    mkdir -p $wallpapers_cache 2> /dev/null
    touch $wallpapers_cache/current
    touch $wallpapers_cache/md5sum
    touch $wallpapers_cache/shuffle

    # md5sum to check if wallpapers changed
    old_md5sum=$(<$wallpapers_cache/md5sum)
    new_md5sum=$(find -L ~/.config/wallpapers | sort | md5sum)

    # current wallpaper
    current=$(<$wallpapers_cache/current)
    if [[ -z $current ]] ; then
        current="none"
    fi

    # next wallpaper from shuffle list
    wallpaper=$(cat $wallpapers_cache/shuffle | grep -A1 $current | tail -n1)

    # if empty, equals current or md5 changed, shuffle again and get first
    if [[ -z $wallpaper ]] || [[ $new_md5sum != $old_md5sum ]] || [[ $current == $wallpaper ]] ; then
        shuf -e ~/.config/wallpapers/* > $wallpapers_cache/shuffle
        printf "%s" "$new_md5sum" > $wallpapers_cache/md5sum
        wallpaper=$(cat $wallpapers_cache/shuffle | head -n1)
    fi

    # persist wallpaper as current
    printf "%s" $wallpaper > $wallpapers_cache/current

    # return wallpaper
    printf "%s" $wallpaper
}


########################################
# Function to change bspwm theme based on wallpaper
#
# Arguments:
#   none
########################################
change_theme() {

    # random wallpaper
    wallpaper=$(random_wallpaper)

    feh --bg-scale $wallpaper
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

