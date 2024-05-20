#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# install necessary packages
install udiskie

# configs
copy_to_root $dir/configs/udisks2.rules /etc/udev/rules.d/99-udisks2.rules
copy_to_root $dir/configs/media.conf /etc/tmpfiles.d/media.conf