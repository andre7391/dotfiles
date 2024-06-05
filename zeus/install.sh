#!/usr/bin/env zsh

# imports
. zdots/utils.sh
. zdots/arch.sh

# parse variables used by zdots logs
parse_vars $0

banner "System"
zdots zeus/system


banner "Window Manager"
zdots zeus/window-manager
zdots shared/window-manager


banner "Appearance and Theming"
zdots shared/theming


banner "Programs"
zdots zeus/programs
zdots shared/programs


banner "Development"
zdots zeus/development

# dots shared/eww
# dots shared/rofi
# dots shared/lf
# dots shared/others
# dots shared/zsh


# dots shared/fonts
# dots shared/wallpapers
# dots shared/wallust
# dots shared/gtk


# banner "Zeus"
# dots zeus/system
# dots zeus/udisks2
# dots zeus/ssh
# dots zeus/bspwm
# dots zeus/eww
# dots zeus/mouse
# dots zeus/programs
# dots zeus/vscode
# dots zeus/rlang
