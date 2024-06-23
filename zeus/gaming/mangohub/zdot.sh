#!/usr/bin/env zsh

# mangohud
install mangohud lib32-mangohud mesa-utils gamemode lib32-gamemode gamescope

# config
symlink $dir/mangohub.conf ~/.config/MangoHud/MangoHud.conf

if ! [[ $(groups | grep gamemode) ]] ; then 
    sudo usermod -a -G gamemode $(whoami)
fi

# >_ gamemoderun gamescope --mangoapp -f -W1920 -H1080 -r165 glxgears