#!/usr/bin/env zsh

# load flags
local flags=($(cat ~/.config/brave/flags.conf)) 

# execute brave
exec /opt/brave-bin/brave ${flags}