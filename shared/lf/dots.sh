#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# install necessary packages
install lf unzip unrar

# symlink
symlink $dir/lfrc ~/.config/lf/lfrc
