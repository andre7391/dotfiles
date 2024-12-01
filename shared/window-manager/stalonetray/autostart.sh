#!/usr/bin/env zsh

pkill stalonetray
sleep 0.5
stalonetray &
sleep 0.1
xdo hide -n stalonetray