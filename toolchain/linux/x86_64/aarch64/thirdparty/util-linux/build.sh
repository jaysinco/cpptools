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
SOURCE_DIR=util-linux-2.39.2

if [ $do_clean -eq 1 ]; then
    rm -rf $SCRIPT_DIR/src
    rm -rf $SCRIPT_DIR/out
fi

if [ ! -d $SCRIPT_DIR/src/$SOURCE_DIR ]; then
    mkdir -p $SCRIPT_DIR/src
    tar -xf $TC_SOURCE_REPO/$SOURCE_DIR.tar.xz -C $SCRIPT_DIR/src
fi

mkdir -p $SCRIPT_DIR/out \
&& \
pushd $SCRIPT_DIR/out \
&& \
../src/$SOURCE_DIR/configure \
    --prefix $TC_INSTALL_DIR \
    --host=$TC_COMPILER_TUPLE \
    --build=$TC_HOST_COMPILER_TUPLE \
    --enable-shared \
    --disable-static \
    --disable-all-programs \
    --enable-libmount \
    --enable-libblkid \
&& \
make -j`nproc` \
&& \
make install
