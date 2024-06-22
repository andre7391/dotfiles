#!/usr/bin/env zsh

# enable boot service
systemctl_enable systemd-boot-update

# boot config
copy_to_root $dir/loader.conf /boot/loader/loader.conf
copy_to_root $dir/arch.conf /boot/loader/entries/arch.conf

