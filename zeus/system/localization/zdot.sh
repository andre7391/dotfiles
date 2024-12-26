#!/usr/bin/env zsh

# locale conf
copy_to_root $dir/locale.conf /etc/locale.conf

# locale gen
if copy_to_root $dir/locale.gen /etc/locale.gen ; then 
    sudo locale-gen
fi

# update locale
sudo localectl set-locale LANG=en_US.UTF-8
