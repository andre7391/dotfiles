#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# script
symlink $dir/mouse.sh ~/.local/bin/mouse.sh

# udev rules
copy_to_root $dir/mouse.rules /etc/udev/rules.d/99-mouse.rules

# comands to make udev rules
# udevadm monitor
# udevadm info -a -p {device found in previous command}