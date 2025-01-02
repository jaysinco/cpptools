#!/bin/bash

set -e

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
git_root="$(git rev-parse --show-toplevel)"
etc_dir=$git_root/etc
src_dir=$git_root/src

xdg-mime default org.kde.okular.desktop application/pdf

echo "-- install archlinux packages"
jq -r ".packages[]" $etc_dir/archinstall/config.json | \
    xargs sudo pacman -S --needed --noconfirm |& \
    grep -v 'is up to date'

mkdir -p $HOME/opt
mkdir -p $HOME/mnt
mkdir -p $HOME/tmp

echo "-- install config files"
cp -rf $etc_dir/bash/.* $HOME/
cp -rf $etc_dir/git/.gitconfig $HOME/
cp -rf $etc_dir/tmux/.tmux.conf $HOME/
cp -rf $etc_dir/xinit/.xinitrc $HOME/

mkdir -p $HOME/.config/fish/
cp -rf $etc_dir/fish/config.fish $HOME/.config/fish/
cp -rf $etc_dir/fish/proxy.fish $HOME/opt/

mkdir -p $HOME/.config/Code/User/
cp -rf $etc_dir/vscode/*.json $HOME/.config/Code/User/

mkdir -p $HOME/.local/share/fcitx5/rime/
cp -rf $etc_dir/rime/*.yaml $HOME/.local/share/fcitx5/rime/

mkdir -p $HOME/.config/sway/
cp -rf $etc_dir/sway/* $HOME/.config/sway/

mkdir -p $HOME/.config/waybar/
cp -rf $etc_dir/waybar/* $HOME/.config/waybar/

mkdir -p $HOME/.config/foot/
cp -rf $etc_dir/foot/foot.ini $HOME/.config/foot/

mkdir -p $HOME/.config/gtk-3.0/
cp -rf $etc_dir/gtk/settings.ini $HOME/.config/gtk-3.0/

mkdir -p $HOME/.config/gtk-4.0/
cp -rf $etc_dir/gtk/settings.ini $HOME/.config/gtk-4.0/

mkdir -p $HOME/.config/systemd/user/
cp -rf $etc_dir/systemd/user/* $HOME/.config/systemd/user/

if [ ! -f "/etc/systemd/system/getty@tty1.service.d/override.conf" ]; then
    echo "-- install getty@tty1 override.conf"
    sudo mkdir -p /etc/systemd/system/getty@tty1.service.d/
    sudo cp -rf $etc_dir/systemd/system/getty@tty1.service.d/override.conf /etc/systemd/system/getty@tty1.service.d/
fi

if [ ! -f "$HOME/.ssh/id_rsa" ]; then
    echo "-- install ssh key"
    mkdir -p $HOME/.ssh
    cp -rf $src_dir/id_rsa $src_dir/id_rsa.pub $HOME/.ssh/
    chmod 700 $HOME/.ssh
    chmod 600 $HOME/.ssh/id_rsa
    chmod 644 $HOME/.ssh/id_rsa.pub
fi

if [ ! -f "$HOME/.config/clash/config.yaml" ]; then
    echo "-- install clash config"
    mkdir -p $HOME/.config/clash
    cp -rf $src_dir/clash.yaml $HOME/.config/clash/config.yaml
    cp -rf $src_dir/Country.mmdb $HOME/.config/clash/
fi

if [ ! -f "/usr/bin/ct-ng" ]; then
    echo "-- install crosstool-ng"
    tar xf $src_dir/crosstool-ng-1.26.0.tar.xz --directory=$HOME
    pushd $HOME/crosstool-ng-1.26.0
    ./configure \
        --prefix=/usr \
        --libexecdir=/usr/lib \
        --with-bash-completion \
        --with-ncurses \
    && make && sudo make install
    popd
    rm -rf $HOME/crosstool-ng-1.26.0
fi

if [[ ! -d "$HOME/opt/flutter" ]]; then
    echo "-- install flutter"
    tar xf $src_dir/flutter_linux_3.27.1-stable.tar.xz --directory=$HOME/opt
fi

function clone_repo() {
    mkdir -p "$1"
    cd "$1"
    if [ ! -d "$1/.git" ]; then
        echo "-- git clone $2 -b $3" \
        && git init \
        && git remote add origin git@gitee.com:$2 \
        && git remote set-url --add --push origin git@gitee.com:$2 \
        && git remote set-url --add --push origin git@e.coding.net:g-twcb9051/$2 \
        && git remote set-url --add --push origin git@github.com:$2 \
        && git fetch \
        && git checkout $3 -b $4
    fi
}

clone_repo $HOME/sw/sinco/cpptools jaysinco/cpptools.git origin/master master
clone_repo $HOME/sw/sinco/atlas jaysinco/atlas.git origin/master master

if [ ! -d "$HOME/opt/microsoft-edge-stable-bin" ]; then
    echo "-- install edge"
    git clone \
        https://aur.archlinux.org/microsoft-edge-stable-bin.git \
        $HOME/opt/microsoft-edge-stable-bin \
    && pushd $HOME/opt/microsoft-edge-stable-bin \
    && makepkg -si --noconfirm
fi

if [[ $(type -P "code") ]]; then
    echo "-- update vscode extensions"
    code --list-extensions | \
        jq --raw-input --slurp 'split("\n")' | \
        jq --indent 4 '{ recommendations: [ .[] | if length > 0 then . else empty end ] }' \
        > $git_root/.vscode/extensions.json
fi

if [ ! -d "$HOME/opt/visual-studio-code-bin" ]; then
    echo "-- install vscode"
    git clone \
        https://aur.archlinux.org/visual-studio-code-bin.git \
        $HOME/opt/visual-studio-code-bin \
    && pushd $HOME/opt/visual-studio-code-bin \
    && makepkg -si --noconfirm
fi

echo done!
