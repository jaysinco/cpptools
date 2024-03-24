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
SOURCE_DIR=libiconv-1.17

if [ $do_clean -eq 1 ]; then
    rm -rf $SCRIPT_DIR/src
    rm -rf $SCRIPT_DIR/out
fi

if [ ! -d $SCRIPT_DIR/src/$SOURCE_DIR ]; then
    mkdir -p $SCRIPT_DIR/src
    tar -xzf $TC_SOURCE_REPO/$SOURCE_DIR.tar.gz -C $SCRIPT_DIR/src
fi

build_aux_path="$SCRIPT_DIR/src/$SOURCE_DIR/build-aux"
lt_compile="$build_aux_path/compile"
lt_ar="$build_aux_path/ar-lib"

export CC="$lt_compile cl -nologo"
export CXX="$lt_compile cl -nologo"
export LD="link"
export STRIP=":"
export AR="$lt_ar lib"
export RANLIB=":"
export NM="dumpbin -symbols"
export win32_target="_WIN32_WINNT_VISTA"
export CFLAGS="-FS -MD -O2 -DDNDEBUG"

mkdir -p $SCRIPT_DIR/out \
&& \
pushd $SCRIPT_DIR/out \
&& \
../src/$SOURCE_DIR/configure \
    --prefix $TC_INSTALL_DIR \
    --enable-shared \
    --disable-static \
&& \
make -j`nproc` \
&& \
make install
