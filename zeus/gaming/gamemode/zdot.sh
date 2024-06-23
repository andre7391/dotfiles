#!/usr/bin/env zsh

# mangohud
install gamemode lib32-gamemode

# group for gamemode
if ! [[ $(groups | grep gamemode) ]] ; then 
    sudo usermod -a -G gamemode $(whoami)
fi
