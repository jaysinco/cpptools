# Linux

## requirement
* install package
```
apt-get install -y build-essential ninja-build automake
```

## install crosstool-ng
* https://github.com/crosstool-ng/crosstool-ng/tree/master/testing/docker
    ```
    apt-get -y install gcc g++ gperf bison flex texinfo help2man make libncurses5-dev \
        python3-dev autoconf automake libtool libtool-bin gawk wget bzip2 xz-utils unzip \
        patch libstdc++6 rsync git meson ninja-build
    ```
* https://crosstool-ng.github.io/docs/install/
    ```
    ./configure --prefix=/some/place
    make
    make install
    export PATH="${PATH}:/some/place/bin"
    ```

## arch linux
* [Installation guide - ArchWiki](https://wiki.archlinux.org/title/Installation_guide)
* [archlinux | 镜像站使用帮助 | 清华大学开源软件镜像站 | Tsinghua Open Source Mirror](https://mirrors.tuna.tsinghua.edu.cn/help/archlinux/)
* [Archiso - ArchWiki](https://wiki.archlinux.org/title/Archiso)
* [Xfce - ArchWiki](https://wiki.archlinux.org/title/xfce)
* [Arch Linux - xfce4-pulseaudio-plugin 0.4.8-1 (x86\_64)](https://archlinux.org/packages/extra/x86_64/xfce4-pulseaudio-plugin/)
* [Arch Linux - gvfs 1.54.0-3 (x86\_64)](https://archlinux.org/packages/extra/x86_64/gvfs/)
* [NetworkManager - ArchWiki](https://wiki.archlinux.org/title/NetworkManager)
* [systemd-resolved - ArchWiki](https://wiki.archlinux.org/title/Systemd-resolved)
* [Arch Linux - base-devel 1-1 (any)](https://archlinux.org/packages/core/any/base-devel/)
* [OpenSSH - ArchWiki](https://wiki.archlinux.org/title/OpenSSH)
* [Arch Linux - clash 1.18.0-1 (x86\_64)](https://archlinux.org/packages/extra/x86_64/clash/)
* [xface如何设置系统代理? - 知乎](https://www.zhihu.com/question/586110918/answer/2910628561)
* [添加Arch Wiki中文字体 - 知乎](https://zhuanlan.zhihu.com/p/494939433)
* [Arch Linux - ttf-hack-nerd 3.2.1-2 (any)](https://archlinux.org/packages/extra/any/ttf-hack-nerd/)
* [Arch Linux - ttf-cascadia-mono-nerd 3.2.1-2 (any)](https://archlinux.org/packages/extra/any/ttf-cascadia-mono-nerd/)
* [fish - ArchWiki](https://wiki.archlinux.org/title/Fish)
* [IBus - ArchWiki](https://wiki.archlinux.org/title/IBus)
* [Rime - ArchWiki](https://wiki.archlinux.org/title/Rime)
* [Arch Linux - neofetch 7.1.0-2 (any)](https://archlinux.org/packages/extra/any/neofetch/)
* [AUR (en) - microsoft-edge-stable-bin](https://aur.archlinux.org/packages/microsoft-edge-stable-bin)
* [AUR (en) - visual-studio-code-bin](https://aur.archlinux.org/packages/visual-studio-code-bin?O=10&PP=10)
* [Arch Linux - rclone 1.66.0-1 (x86\_64)](https://archlinux.org/packages/extra/x86_64/rclone/)
* [tmux - ArchWiki](https://wiki.archlinux.org/title/tmux)
* [Arch Linux - nnn 4.9-1 (x86\_64)](https://archlinux.org/packages/extra/x86_64/nnn/)
* [Arch Linux - qemu-emulators-full 9.0.1-1 (x86\_64)](https://archlinux.org/packages/extra/x86_64/qemu-emulators-full/)
* [Arch Linux - qemu-base 9.0.1-1 (x86\_64)](https://archlinux.org/packages/extra/x86_64/qemu-base/)


# Windows

## requirement
* Visual Studio
* MSYS2
* run `set-msys.sh`
* Git Portable
* cmake
* ninja
* Strawberry Perl Portable
* nasm
