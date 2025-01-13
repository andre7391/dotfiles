#!/usr/bin/env zsh

pkill eww
sleep 1
eww daemon
eww open bar-window
xdo below -t $(xdo id -n root) $(xdo id -n eww)