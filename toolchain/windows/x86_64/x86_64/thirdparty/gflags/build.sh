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
SOURCE_DIR=gflags-2.2.2

if [ $do_clean -eq 1 ]; then
    rm -rf $SCRIPT_DIR/src
    rm -rf $SCRIPT_DIR/out
fi

if [ ! -d $SCRIPT_DIR/src/$SOURCE_DIR ]; then
    mkdir -p $SCRIPT_DIR/src
    tar -xzf $TC_SOURCE_REPO/$SOURCE_DIR.tar.gz -C $SCRIPT_DIR/src
fi

mkdir -p $SCRIPT_DIR/out \
&& \
pushd $SCRIPT_DIR/out \
&& \
cmake ../src/$SOURCE_DIR -G "Ninja" \
    -DCMAKE_TOOLCHAIN_FILE=$TC_CMAKE_TOOLCHAIN \
    -DCMAKE_INSTALL_PREFIX=$TC_INSTALL_DIR \
    -DCMAKE_FIND_ROOT_PATH=$TC_INSTALL_DIR \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_MSVC_RUNTIME_LIBRARY="MultiThreadedDLL" \
    -DBUILD_SHARED_LIBS=ON \
&& \
cmake --build . --parallel=`nproc` \
&& \
cmake --install .
