#!/bin/bash

set -e

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
git_root="$(git rev-parse --show-toplevel)"

mkdir -p $HOME/tmp
mkdir -p $HOME/sw/sinco
mkdir -p $HOME/opt

cp -rf $git_root/etc/bash/.* $HOME/
cp -rf $git_root/etc/git/.gitconfig $HOME/
cp -rf $git_root/etc/tmux/.tmux.conf $HOME/
cp -rf $git_root/etc/xinit/.xinitrc $HOME/

mkdir -p $HOME/.config/fish/
cp -rf $git_root/etc/fish/config.fish $HOME/.config/fish/
cp -rf $git_root/etc/fish/proxy.fish $HOME/opt/

mkdir -p $HOME/.config/Code/User/
cp -rf $git_root/etc/vscode/*.json $HOME/.config/Code/User/

if [ ! -d "$HOME/opt/microsoft-edge-stable-bin" ]; then
    git clone \
        https://aur.archlinux.org/microsoft-edge-stable-bin.git \
        $HOME/opt/microsoft-edge-stable-bin
fi

if [ ! -d "$HOME/opt/visual-studio-code-bin" ]; then
    git clone \
        https://aur.archlinux.org/visual-studio-code-bin.git \
        $HOME/opt/visual-studio-code-bin
fi
