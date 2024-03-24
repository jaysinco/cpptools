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
SOURCE_DIR=sqlite-version-3.44.2

if [ $do_clean -eq 1 ]; then
    rm -rf $SCRIPT_DIR/src
    rm -rf $SCRIPT_DIR/out
fi

if [ ! -d $SCRIPT_DIR/src/$SOURCE_DIR ]; then
    mkdir -p $SCRIPT_DIR/src
    tar -xzf $TC_SOURCE_REPO/$SOURCE_DIR.tar.gz -C $SCRIPT_DIR/src
fi

if [ ! -f "/usr/bin/tclsh" ]; then
    echo "-- install tclsh"
    sudo apt-get -y install tclsh
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
    --disable-tcl \
&& \
make -j`nproc` \
&& \
make install
