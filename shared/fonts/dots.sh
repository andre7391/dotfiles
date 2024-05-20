#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# current script name
script=${BASH_SOURCE[0]}

# symlink
symlink $dir/dejavu-sans ~/.local/share/fonts/dejavu-sans
symlink $dir/nerdfonts ~/.local/share/fonts/nerdfonts
symlink $dir/roboto ~/.local/share/fonts/roboto
symlink $dir/ubuntu ~/.local/share/fonts/ubuntu

# compare md5sum to check if the fonts changed
touch ~/.local/share/fonts-md5sum
old=$(<~/.local/share/fonts-md5sum)
new=$(find -L ~/.local/share/fonts | sort | md5sum)

# when changed, update cache
if [[ $old != $new ]] ; then 
    sudo fc-cache -f >> /dev/null
    printf "%s" "$new" > ~/.local/share/fonts-md5sum
    log_info "fonts successfully installed at ${cyan}[$HOME/.local/share/fonts]${normal}" "$script"
fi
