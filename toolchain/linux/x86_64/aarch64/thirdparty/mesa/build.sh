#!/bin/bash

set -e

do_clean=0

while [[ $# -gt 0 ]]; do
    case $1 in
         -c) do_clean=1 && shift ;;
          *) echo "Unknown option: $1" && exit 1 ;;
    esac
done

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $TC_TOOLCHAIN_DIR/env.sh
SOURCE_DIR=mesa-20.3.5

if [ $do_clean -eq 1 ]; then
    rm -rf $SCRIPT_DIR/src
    rm -rf $SCRIPT_DIR/out
fi

if [ ! -d $SCRIPT_DIR/src/$SOURCE_DIR ]; then
    mkdir -p $SCRIPT_DIR/src
    tar -xf $TC_SOURCE_REPO/$SOURCE_DIR.tar.xz -C $SCRIPT_DIR/src
fi

# if [ ! -f "/usr/bin/glslangValidator" ]; then
#     echo "missing! glslang-tools"
#     exit 1
# fi

# if [ ! -f "/usr/bin/llvm-config" ]; then
#     echo "missing! llvm-dev"
#     exit 1
# fi

if ! grep -q Mako <<< `pip3 list`; then
    echo "-- install mako"
    pip3 install Mako setuptools -i https://pypi.tuna.tsinghua.edu.cn/simple --break-system-packages
fi

pushd $SCRIPT_DIR/src/$SOURCE_DIR \
&& \
meson setup $SCRIPT_DIR/out \
    --prefix=$TC_INSTALL_DIR \
    --cross-file $TC_MESON_CROSSFILE \
    -Dbuildtype=release \
    -Dplatforms=x11,wayland \
    -Ddri-drivers=nouveau \
    -Dgallium-drivers= \
    -Dvulkan-drivers= \
    -Degl=enabled \
&& \
meson compile -C $SCRIPT_DIR/out \
&& \
meson install -C $SCRIPT_DIR/out
