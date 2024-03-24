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
SOURCE_DIR=marisa-trie-0.2.6

if [ $do_clean -eq 1 ]; then
    rm -rf $SCRIPT_DIR/src
    rm -rf $SCRIPT_DIR/out
fi

if [ ! -d $SCRIPT_DIR/src/$SOURCE_DIR ]; then
    mkdir -p $SCRIPT_DIR/src
    tar -xzf $TC_SOURCE_REPO/$SOURCE_DIR.tar.gz -C $SCRIPT_DIR/src
fi

pushd $SCRIPT_DIR/src/$SOURCE_DIR \
&& \
autoreconf -i \
&& \
./configure \
    --with-sysroot=$TC_SYSROOT \
    --prefix $TC_INSTALL_DIR \
    --host=$TC_COMPILER_TUPLE \
    --build=$TC_HOST_COMPILER_TUPLE \
    --enable-shared \
    --disable-static \
    --enable-native-code \
&& \
make -j`nproc` \
&& \
make install
