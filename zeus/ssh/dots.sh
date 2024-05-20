#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# ssh package
install openssh

if ! [[ -f ~/.ssh/id_ed25519 ]] ; then
    ssh-keygen -t ed25519 -C "andre7391@gmail.com.com"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
fi