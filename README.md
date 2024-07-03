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
