#!/usr/bin/env zsh

# install necessary packages
install zsh starship

# set zsh as default shell
if [[ ! $SHELL =~ 'zsh' ]] ; then
    chsh -s /usr/bin/zsh
fi

# symlink
symlink $dir/configs/starship.toml ~/.config/starship.toml
symlink $dir/configs/zshrc ~/.zshrc
symlink $dir/configs/zshenv ~/.zshenv
