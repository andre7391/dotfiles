#!/usr/bin/env zsh

# install eww if nedded
if ! is_installed --quiet eww ; then
    # subshell 
    (
        rm -rf /tmp/eww 2> /dev/null
        git clone https://github.com/elkowar/eww.git /tmp/eww
        cd /tmp/eww
        cargo build --release --no-default-features --features x11
        sudo cp -f ./target/release/eww /usr/local/bin
        log_info "packages installed successfully ${cyan}[eww]${normal}"
    )
fi

# symlink configs
symlink $dir/eww.yuck ~/.config/eww/eww.yuck
symlink $dir/eww.scss ~/.config/eww/eww.scss
symlink $dir/scripts/default.sh ~/.config/eww/scripts/default.sh
