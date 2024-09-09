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
SOURCE_DIR=libcap-2.66

if [ $do_clean -eq 1 ]; then
    rm -rf $SCRIPT_DIR/src
    rm -rf $SCRIPT_DIR/out
fi

if [ ! -d $SCRIPT_DIR/src/$SOURCE_DIR ]; then
    mkdir -p $SCRIPT_DIR/src
    tar -xf $TC_SOURCE_REPO/$SOURCE_DIR.tar.xz -C $SCRIPT_DIR/src
fi

export BUILD_CC=$TC_COMPILER_CC
export DESTDIR=$TC_INSTALL_DIR
export SHARED="yes"
export PTHREADS="yes"
export prefix=""
export lib="lib"

mkdir -p $SCRIPT_DIR/out \
&& \
pushd $SCRIPT_DIR/src/$SOURCE_DIR/libcap \
&& \
make CC=$TC_COMPILER_CC -j`nproc` \
&& \
make install-shared-cap
