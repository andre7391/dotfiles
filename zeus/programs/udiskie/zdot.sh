#!/usr/bin/env zsh

# install necessary packages
install udiskie

# symlink configs
copy_to_root $dir/configs/udisks2.rules /etc/udev/rules.d/99-udisks2.rules
copy_to_root $dir/configs/media.conf /etc/tmpfiles.d/media.conf
copy_to_root $dir/configs/mount_options.conf /etc/udisks2/mount_options.conf

# symlink autostart
symlink $dir/autostart.sh ~/.config/bspwm/autostart/udiskie.sh
