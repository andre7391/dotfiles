#!/usr/bin/env zsh

# update timezone
timezone=/usr/share/zoneinfo/America/Campo_Grande
# timezone=/usr/share/zoneinfo/America/Sao_Paulo
if [[ $(readlink -f /etc/localtime) != $(readlink -f $timezone) ]] ; then
    sudo ln -sf $timezone /etc/localtime
    log_info "timezone updated to ${cyan}[$timezone]${normal}"
fi 


# check if adjtime is UTC
if ! grep -q UTC /etc/adjtime 2> /dev/null ; then
    sudo hwclock -w
    log_info "hwclock adjusted to ${cyan}[UTC]${normal}"
fi

# enable timesync
systemctl_enable systemd-timesyncd