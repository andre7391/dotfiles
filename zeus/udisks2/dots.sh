#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# check if package is installed
if is_arch ; then 
    arch_install udiskie
else
    is_installed udiskie
fi

# udev rules
copy_to_root $dir/udisks2.rules /etc/udev/rules.d/99-udisks2.rules

# mount rules
copy_to_root $dir/media.conf /etc/tmpfiles.d/media.conf