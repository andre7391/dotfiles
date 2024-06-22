#!/usr/bin/env zsh

# variables used by zdots
file=$0
dir=$(dirname $0)

# imports
. $dir/zdots/utils.sh
. $dir/zdots/arch.sh


# run zdots
banner "System"
zdots $dir/zeus/system/yay
zdots $dir/zeus/system/packages
zdots $dir/zeus/system
zdots $dir/shared/system


banner "Window Manager"
zdots $dir/zeus/window-manager/eww
zdots $dir/zeus/window-manager
zdots $dir/shared/window-manager


banner "Appearance and Theming"
zdots $dir/shared/theming


banner "Programs"
zdots $dir/zeus/programs
zdots $dir/shared/programs


banner "Development"
zdots $dir/zeus/development


banner "Gaming"
zdots $dir/zeus/gaming


banner "Clean and Packages Symlinks"
clean_symlinks $dir
clean_packages
