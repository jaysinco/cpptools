#!/bin/bash

set -e

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
git_root="$(git rev-parse --show-toplevel)"
etc_dir=$git_root/etc
src_dir=$git_root/src

jq -r ".packages[]" $etc_dir/archinstall/config.json | \
    xargs sudo pacman -S --needed --noconfirm

mkdir -p $HOME/tmp
mkdir -p $HOME/opt

cp -rf $etc_dir/bash/.* $HOME/
cp -rf $etc_dir/git/.gitconfig $HOME/
cp -rf $etc_dir/tmux/.tmux.conf $HOME/
cp -rf $etc_dir/xinit/.xinitrc $HOME/

mkdir -p $HOME/.config/fish/
cp -rf $etc_dir/fish/config.fish $HOME/.config/fish/
cp -rf $etc_dir/fish/proxy.fish $HOME/opt/

mkdir -p $HOME/.config/Code/User/
cp -rf $etc_dir/vscode/*.json $HOME/.config/Code/User/

mkdir -p $HOME/.config/ibus/rime/
cp -rf $etc_dir/rime/*.yaml $HOME/.config/ibus/rime/

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

function clone_repo() {
    mkdir -p "$1"
    cd "$1"
    if [ ! -d "$1/.git" ]; then
        echo "-- git clone $2 -b $3" \
        && git init \
        && git remote add origin git@gitee.com:$2 \
        && git fetch \
        && git checkout $3 -b $4 \
        && git remote add backup git@github.com:$2
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
