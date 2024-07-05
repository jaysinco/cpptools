#!/bin/bash

set -e

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
git_root="$(git rev-parse --show-toplevel)"
etc_dir=$git_root/etc
src_dir=$git_root/src

mkdir -p $HOME/tmp
mkdir -p $HOME/sw/sinco
mkdir -p $HOME/opt

cp -rf $etc_dir/bash/.* $HOME/
cp -rf $etc_dirgit/.gitconfig $HOME/
cp -rf $etc_dir/tmux/.tmux.conf $HOME/
cp -rf $etc_dir/xinit/.xinitrc $HOME/

mkdir -p $HOME/.config/fish/
cp -rf $etc_dir/fish/config.fish $HOME/.config/fish/
cp -rf $etc_dir/fish/proxy.fish $HOME/opt/

mkdir -p $HOME/.config/Code/User/
cp -rf $etc_dir/vscode/*.json $HOME/.config/Code/User/

mkdir -p $HOME/.config/ibus/rime/
cp -rf $etc_dirrime/*.yaml $HOME/.config/ibus/rime/

if [ ! -f "$HOME/.ssh/id_rsa" ]; then
    echo "-- install ssh key"
    mkdir -p $HOME/.ssh
    cp -rf $src_dir/id_rsa $src_dir/id_rsa.pub $HOME/.ssh/
    chmod 700 $HOME/.ssh
    chmod 600 $HOME/.ssh/id_rsa
    chmod 644 $HOME/.ssh/id_rsa.pub
fi

if [ ! -f "$HOME/.config/clash/Country.mmdb" ]; then
    echo "-- install clash config"
    mkdir -p $HOME/.config/clash
    cp -rf $src_dir/clash.yaml $HOME/.config/clash/config.yaml
    cp -rf $src_dir/Country.mmdb $HOME/.config/clash/
fi

if [ ! -f "/usr/bin/ct-ng" ]; then
    echo "-- install crosstool-ng"
    tar xf $src_dir/crosstool-ng-1.26.0.tar.xz --directory=$HOME
    pushd $HOME/crosstool-ng-1.26.0
    ./configure --prefix=/usr && make && sudo make install
    popd
    rm -rf $HOME/crosstool-ng-1.26.0
fi

if [ ! -d "$HOME/opt/microsoft-edge-stable-bin" ]; then
    echo "-- install edge"
    git clone \
        https://aur.archlinux.org/microsoft-edge-stable-bin.git \
        $HOME/opt/microsoft-edge-stable-bin \
    && pushd $HOME/opt/microsoft-edge-stable-bin \
    && makepkg -si
fi

if [ ! -d "$HOME/opt/visual-studio-code-bin" ]; then
    echo "-- install vscode"
    git clone \
        https://aur.archlinux.org/visual-studio-code-bin.git \
        $HOME/opt/visual-studio-code-bin \
    && pushd $HOME/opt/visual-studio-code-bin \
    && makepkg -si
fi
