#!/usr/bin/env zsh

pkill picom
sleep 0.5
picom --daemon --config ~/.config/picom/picom.conf 