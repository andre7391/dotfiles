#!/usr/bin/env zsh

# install eww if nedded
if ! is_installed --quiet eww ; then
    # subshell 
    (
        cache_dir=~/.cache/zdots/eww
        if ! [[ -d $cache_dir ]] ; then
            git clone https://github.com/elkowar/eww.git $cache_dir
        fi
        cd $cache_dir
        git pull
        cargo build --release --no-default-features --features x11
        sudo cp -f ./target/release/eww /usr/local/bin
        log_info "packages installed successfully ${cyan}[eww]${normal}"
    )
fi

# symlink configs
symlink $dir/components.yuck ~/.config/eww/components.yuck
symlink $dir/eww.scss ~/.config/eww/eww.scss
symlink $dir/utilities.sh ~/.config/eww/utilities.sh

# symlink autostart
symlink $dir/autostart.sh ~/.config/bspwm/autostart/eww.sh
