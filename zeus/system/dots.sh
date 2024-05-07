#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# system packages
arch_install amd-ucode
arch_install xorg
arch_install xorg-xinit
arch_install rust
arch_install openssh
