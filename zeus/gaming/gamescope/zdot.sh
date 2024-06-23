#!/usr/bin/env zsh

# mangohud
install gamescope

if ! [[ $(getcap $(which gamescope) | grep cap_sys_nice=eip) ]] ; then
    sudo setcap 'CAP_SYS_NICE=eip' $(which gamescope)
fi

# >_ gamemoderun gamescope --mangoapp -f -W1920 -H1080 -r165 glxgears