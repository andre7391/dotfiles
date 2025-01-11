#!/usr/bin/env zsh

# configure dpms
xset s 0 0
xset dpms 300 300 300

# run xss-lock
pkill xss-lock
sleep 0.5
xss-lock -n /usr/lib/xsecurelock/dimmer -l -- xsecurelock