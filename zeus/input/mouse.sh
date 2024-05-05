#!/usr/bin/env bash

export DISPLAY=:0
export XAUTHORITY=/home/andre/.Xauthority

(
  sleep 0.5
  xinput set-prop pointer:"Logitech G603" "libinput Accel Profile Enabled" 0 1 0
) & disown