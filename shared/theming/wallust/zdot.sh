#!/usr/bin/env zsh

# install wallust if nedded
if ! is_installed --quiet wallust ; then
    # subshell 
    (
        cache_dir=~/.cache/zdots/wallust
        if ! [[ -d $cache_dir ]] ; then
            git clone https://codeberg.org/explosion-mental/wallust.git $cache_dir
        fi
        cd $cache_dir
        git pull
        git checkout dev
        cargo build --release
        sudo cp -f ./target/release/wallust /usr/local/bin
        log_info "packages installed successfully ${cyan}[wallust]${normal}"
    )
fi

# symlink wallust files
symlink $dir/wallust.toml ~/.config/wallust/wallust.toml
symlink $dir/templates ~/.config/wallust/templates
symlink $dir/utilities.sh ~/.config/wallust/utilities.sh

# symlink autostart
symlink $dir/autostart.sh ~/.config/bspwm/autostart/wallust.sh

