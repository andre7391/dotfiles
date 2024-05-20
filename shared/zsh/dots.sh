#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# install necessary packages
install zsh starship

# set zsh as default shell
if [[ ! $SHELL =~ 'zsh' ]] ; then
    chsh -s /usr/bin/zsh
fi

# symlink
symlink $dir/starship.toml ~/.config/starship.toml
symlink $dir/zshrc ~/.zshrc
