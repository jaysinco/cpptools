# Linux
## install crosstool-ng
* https://github.com/crosstool-ng/crosstool-ng/tree/master/testing/docker
    ```
    apt -y install gcc g++ gperf bison flex texinfo help2man make libncurses5-dev \
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

# Windows
* install MSYS2
* run `set-msys.sh`
