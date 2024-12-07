#!/usr/bin/env zsh

# install and enable network management services
install iwd
systemctl_enable iwd systemd-resolved systemd-networkd

# hostname
copy_to_root $dir/hostname /etc/hostname
copy_to_root $dir/wireless.network /etc/systemd/network/25-wireless.network
copy_to_root $dir/resolved.conf /etc/systemd/resolved.conf
copy_to_root /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
