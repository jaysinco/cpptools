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
SOURCE_DIR=coremark-1.01

if [ $do_clean -eq 1 ]; then
    rm -rf $SCRIPT_DIR/src
    rm -rf $SCRIPT_DIR/out
fi

if [ ! -d $SCRIPT_DIR/src/$SOURCE_DIR ]; then
    mkdir -p $SCRIPT_DIR/src
    tar -xzf $TC_SOURCE_REPO/$SOURCE_DIR.tar.gz -C $SCRIPT_DIR/src
fi

COMPILER_FLAGS="-O2 -DPERFORMANCE_RUN=1"

pushd $SCRIPT_DIR/src/$SOURCE_DIR \
&& \
make link \
    PORT_DIR=linux64 \
    CC=$TC_COMPILER_CC \
    CXX=$TC_COMPILER_CXX \
    LD=$TC_COMPILER_BINDIR/$TC_COMPILER_TUPLE-ld \
    STRIP=$TC_COMPILER_BINDIR/$TC_COMPILER_TUPLE-strip \
    AR=$TC_COMPILER_BINDIR/$TC_COMPILER_TUPLE-ar \
    RANLIB=$TC_COMPILER_BINDIR/$TC_COMPILER_TUPLE-ranlib \
    XCFLAGS="$COMPILER_FLAGS" \
    C_INCLUDE_PATH="$SCRIPT_DIR/src/$SOURCE_DIR:$SCRIPT_DIR/src/$SOURCE_DIR/linux64" \
    CFLAGS="--sysroot=$TC_SYSROOT -fPIC -DCOMPILER_FLAGS='\"$COMPILER_FLAGS\"'" \
    LDFLAGS="--sysroot=$TC_SYSROOT" \
    -j`nproc` \
&& \
mkdir -p $TC_INSTALL_DIR/bin \
&& \
cp ./coremark.exe $TC_INSTALL_DIR/bin/coremark
