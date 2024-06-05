#!/usr/bin/env zsh

# install wallust if nedded
if ! is_installed --quiet wallust ; then
    # subshell 
    (
        rm -rf /tmp/wallust 2> /dev/null
        git clone https://codeberg.org/explosion-mental/wallust.git /tmp/wallust
        cd /tmp/wallust
        git checkout dev
        cargo build --release
        sudo cp -f ./target/release/wallust /usr/local/bin
        log_info "packages installed successfully ${cyan}[wallust]${normal}"
    )
fi

# wallpapers
symlink $dir/wallust.toml ~/.config/wallust/wallust.toml
symlink $dir/templates ~/.config/wallust/templates

