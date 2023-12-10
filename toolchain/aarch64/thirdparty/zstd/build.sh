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
source $SCRIPT_DIR/../../env.sh
SOURCE_DIR=zstd-1.5.5

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
cmake ../src/$SOURCE_DIR/build/cmake -G "Unix Makefiles" \
    -DCMAKE_TOOLCHAIN_FILE=$TC_CMAKE_TOOLCHAIN \
    -DCMAKE_INSTALL_PREFIX=$TC_INSTALL_DIR \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
    -DBUILD_SHARED_LIBS=ON \
    -DBUILD_TESTING=OFF \
    -DZSTD_BUILD_PROGRAMS=OFF \
    -DZSTD_BUILD_SHARED=ON \
    -DZSTD_BUILD_STATIC=OFF \
    -DZSTD_MULTITHREAD_SUPPORT=ON \
&& \
cmake --build . --parallel=`nproc` \
&& \
cmake --install .
