#!/usr/bin/env zsh

########################################
# Function to update workspaces
########################################
update_workspaces() {
    
    occupied=($(bspc query -D -d .occupied --names))
    focused=($(bspc query -D -d .focused --names))
    urgent=($(bspc query -D -d .urgent --names))

    # merge occupied and focused removing duplicates
    workspaces=(${occupied[@]} ${focused[@]})
    workspaces=($(printf '%s\n' ${workspaces[@]} | sort -u))

    # check if layout is monocle
    is_monocle=$(bspc query -T -d | grep -q '"userLayout":"monocle"' && echo "0")

    local output=""

    for workspace in ${workspaces[@]} ; do

        workspace_text=$workspace

        if [[ ${focused[@]} =~ $workspace ]] ; then
            class="workspace focused"   
        elif [[ ${urgent[@]} =~ $workspace ]] ; then
            class="workspace urgent"
        else
            class="workspace"
        fi

        if [[ $workspace == ${workspaces[0]} ]] ; then
            class="$class first"
        fi
        
        if [[ $workspace == ${workspaces[-1]} ]] ; then
            class="$class last"
        fi

        # if [[ $is_monocle && ${focused[@]} =~ $workspace ]]; then
        #     workspace_text=$workspace" Monocle"
        # fi

        output="$output (eventbox :cursor \"hand\" :onclick \"bspc desktop -f $workspace\" (label :class \"$class\" :text \"$workspace_text\"))"
    done

    eww update workspaces_var="(box :space-evenly false :class \"workspaces\" $output)"
}

########################################
# Function to update window title
########################################
update_window_title() {
    eww update window_title_var="$(xprop -id $(bspc query -N -n focused) | grep _NET_WM_NAME | cut -d'"' -f2)"
}


########################################
# Function to print and watch bspwm layout
########################################
print_bspwm_layout() {
    
    if $(bspc query -T -d | grep -q '"userLayout":"monocle"') ; then
        printf '%s\n' "Monocle"
    else
        printf '%s\n' "Tiled"
    fi
}

watch_bspwm_layout() {

    # trap to kill all child process
    trap 'kill $(jobs -p)' EXIT

    # first print to avoid starting empty
    print_bspwm_layout

    # watch workspaces changes
    bspc subscribe desktop node_transfer | while read -r _ ; do
        print_bspwm_layout
    done
}

########################################
# Funnctions to get / set output audio volume and icon
########################################
get_output_audio_volume() {
    if [[ $(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}') == "yes" ]] ; then 
        echo "mute"
    else
        pactl get-sink-volume @DEFAULT_SINK@ | awk 'NR==1{print $5}' | tr -d '%'
    fi
}

get_output_audio_icon() {
    volume=$(get_output_audio_volume)
    if [[ $volume == "mute" ]] ; then 
        echo ""
    elif ((volume > 66)); then 
        echo ""
    elif ((volume > 33)); then 
        echo ""
    else
        echo ""
    fi
}

set_output_audio_volume() {

    volume=$(get_output_audio_volume)

    # unmute
    if [[ $volume = "mute" ]] ; then 
        toggle_output_audio_mute
    fi

    # calculate audio volume
    if [[ $1 = "up" ]]; then 
        volume=$((volume + 2))
        if ((volume >= 140)); then 
            volume=140
        fi
    else 
        volume=$((volume - 2))
        if ((volume <= 0)); then 
            volume=0
        fi
    fi

    # round volume
    volume=$(( volume / 2 * 2 ))

    pactl set-sink-volume @DEFAULT_SINK@ $volume%
}

toggle_output_audio_mute() {
    pactl set-sink-mute @DEFAULT_SINK@ toggle
}

subscribe_output_audio_icon() {
    get_output_audio_icon
    pactl subscribe | grep --line-buffered "sink" | while read -r line; do
        get_output_audio_icon
    done 
}

subscribe_output_audio_volume() {
    get_output_audio_volume
    pactl subscribe | grep --line-buffered "sink" | while read -r line; do
        get_output_audio_volume
    done 
}

########################################
# Funnctions to get / set input audio volume and icon
########################################
get_input_audio_volume() {
    if [[ $(pactl get-source-mute @DEFAULT_SOURCE@ | awk '{print $2}') = "yes" ]]; then 
        echo "mute"
    else
        pactl get-source-volume @DEFAULT_SOURCE@ | awk 'NR==1{print $5}' | tr -d '%'
    fi
}

get_input_audio_icon() {
    volume=$(get_input_audio_volume)
    if [ $volume = "mute" ]; then 
        echo ""
    else
        echo ""
    fi
}

set_input_audio_volume() {

    volume=$(get_input_audio_volume)

    # unmute
    if [ $volume = "mute" ]; then 
        toggle_input_audio_mute
    fi

    # calculate volume
    if [ $1 = "up" ]; then 
        volume=$((volume + 2))
        if ((volume >= 100)); then 
            volume=100
        fi
    else 
        volume=$((volume - 2))
        if ((volume <= 0)); then 
            volume=0
        fi
    fi

    # round volume
    volume=$(( volume / 2 * 2 ))
    
    pactl set-source-volume @DEFAULT_SOURCE@ $volume%
}

toggle_input_audio_mute() {
    pactl set-source-mute @DEFAULT_SOURCE@ toggle
}

subscribe_input_audio_icon() {
    get_input_audio_icon
    pactl subscribe | grep --line-buffered "source" | while read -r line; do
        get_input_audio_icon
    done 
}

subscribe_input_audio_volume() {
    get_input_audio_volume
    pactl subscribe | grep --line-buffered "source" | while read -r line; do
        get_input_audio_volume
    done 
}

########################################
# Function to get wifi name
########################################
wifi_name() {
    local name=$(iwctl station wlan0 show | grep "Connected network" | awk '{print $3}') 2> /dev/null

    if [[ -z $name ]] ; then
        name=$(nmcli | grep "^wl" | awk 'sub(/.*connected to /,"") {print $1}')
    fi

    echo $name
}


########################################
# Function toogle stalonetray
########################################
toggle_stalonetray() {
    if $(xwininfo -name stalonetray | grep -q IsViewable) ; then
        xdo hide -n stalonetray
    else
        xdo show -n stalonetray
    fi
}

"$@"
