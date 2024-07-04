#!/bin/bash

set -e

git config --global core.autocrlf true
git config --global core.safecrlf false
git config --global core.longpaths true
git config --global core.quotepath false
git config --global i18n.filesEncoding utf-8
git config --global pull.rebase false
git config --global fetch.prune true

pacman_need_sync=0
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
git_root="$(git rev-parse --show-toplevel)"

function modify_mirror() {
    if [ "$(head -n 1 $1)" != "$2" ]; then
        echo "modify $1"
        sed -i "1s|^|$2\n|" $1
        pacman_need_sync=1
    fi
}

modify_mirror /etc/pacman.d/mirrorlist.mingw32 'Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/mingw/i686'
modify_mirror /etc/pacman.d/mirrorlist.mingw64 'Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/mingw/x86_64'
modify_mirror /etc/pacman.d/mirrorlist.ucrt64  'Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/mingw/ucrt64'
modify_mirror /etc/pacman.d/mirrorlist.clang64 'Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/mingw/clang64'
modify_mirror /etc/pacman.d/mirrorlist.msys    'Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/msys/$arch'

if [ $pacman_need_sync -eq 1 ]; then pacman --noconfirm -Sy; fi

if [ ! -f "/etc/profile.d/git-prompt.sh" ]; then
    echo "copy git-prompt.sh"
    cp $git_root/etc/msys/git-prompt.sh /etc/profile.d/
fi

s1='shopt -q login_shell || . /etc/profile.d/git-prompt.sh'
if ! grep -q "$s1" ~/.bashrc; then
    echo "change ~/.bashrc for git prompt"
    echo "$s1" >> ~/.bashrc
fi

if [ ! -f "/usr/bin/gcc" ]; then pacman --noconfirm -S base-devel binutils gcc; fi
if [ ! -f "/usr/bin/zip" ]; then pacman --noconfirm -S zip; fi
if [ ! -f "/usr/bin/unzip" ]; then pacman --noconfirm -S unzip; fi
if [ ! -f "/mingw64/bin/jq" ]; then pacman --noconfirm -S mingw-w64-x86_64-jq; fi
