#!/usr/bin/env zsh

# packges for secure boot
# install sbctl efitools

# boot config
copy_to_root $dir/loader.conf /boot/loader/loader.conf
copy_to_root $dir/arch.conf /boot/loader/entries/arch.conf

