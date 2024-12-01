#!/usr/bin/env zsh

########################################
# Shuffle and return a random wallpaper
#
# Arguments:
#   none
########################################
get_random_wallpaper() {
    
    # constants
    readonly wallpapers_cache=~/.cache/wallpapers

    # create dir and files if they dont exists
    mkdir -p $wallpapers_cache 2> /dev/null
    touch $wallpapers_cache/current
    touch $wallpapers_cache/md5sum
    touch $wallpapers_cache/shuffle

    # md5sum to check if wallpapers changed
    old_md5sum=$(<$wallpapers_cache/md5sum)
    new_md5sum=$(find -L ~/.config/wallpapers -type f | sort | md5sum)

    # current wallpaper
    current=$(<$wallpapers_cache/current)
    if [[ -z $current ]] ; then
        current="none"
    fi

    # next wallpaper from shuffle list
    wallpaper=$(cat $wallpapers_cache/shuffle | grep -A1 $current | tail -n1)

    # if empty, equals current or md5 changed, shuffle again and get first
    if [[ -z $wallpaper ]] || [[ $new_md5sum != $old_md5sum ]] || [[ $current == $wallpaper ]] ; then
        find -L ~/.config/wallpapers -type f | shuf > $wallpapers_cache/shuffle
        printf "%s" "$new_md5sum" > $wallpapers_cache/md5sum
        wallpaper=$(cat $wallpapers_cache/shuffle | head -n1)
    fi

    # persist wallpaper as current
    printf "%s" $wallpaper > $wallpapers_cache/current

    # return wallpaper
    printf "%s" $wallpaper
}


########################################
# Set theme colors to bspwm
#
# Arguments:
#   none
########################################
bspwm_colors() {
    # load wallust colors
    . ~/.cache/wallust/colors.sh

    # set colors to bspwm
    bspc config normal_border_color "$color10"
    bspc config active_border_color "$color13"
    bspc config focused_border_color "$color15"
    bspc config presel_feedback_color "$color13"
}

########################################
# Change to the next wallpaper
#
# Arguments:
#   none
########################################
next_wallpaper() {

    # random wallpaper
    wallpaper=$(get_random_wallpaper)

    # set wallpaper
    feh --bg-scale $wallpaper

    # run wallust
    wallust run -s $wallpaper

    # reload kitty colors
    kill -SIGUSR1 $(pidof kitty) # reload kitty

    # reload bspwm colors
    bspwm_colors

    # reload eww colors
    eww reload
    sleep 0.5
    xdo below -t $(xdo id -n root) $(xdo id -n eww)

    # reload gtk colors
    pkill xsettingsd
    sleep 0.5
    xsettingsd &
}
