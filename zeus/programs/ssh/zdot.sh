#!/usr/bin/env zsh

# ssh package
install openssh

# generate personal ssh key
if ! [[ -f ~/.ssh/id_ed25519_personal ]] ; then
    ssh-keygen -N "" -f ~/.ssh/id_ed25519_personal -t ed25519 -C "andre7391@gmail.com"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519_personal
fi

# generate mensurepec ssh key
if ! [[ -f ~/.ssh/id_ed25519_mensurepec ]] ; then
    ssh-keygen -N "" -f ~/.ssh/id_ed25519_mensurepec -t ed25519 -C "andre.rodrigues@mensurepec.com"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519_mensurepec
fi

# symlink ssh config
symlink $dir/config ~/.ssh/config
