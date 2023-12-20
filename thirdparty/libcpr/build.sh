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
SOURCE_DIR=cpr-1.10.5

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
cmake ../src/$SOURCE_DIR -G "Unix Makefiles" \
    -DCMAKE_TOOLCHAIN_FILE=$TC_CMAKE_TOOLCHAIN \
    -DCMAKE_INSTALL_PREFIX=$TC_INSTALL_DIR \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
    -DBUILD_SHARED_LIBS=ON \
    -DCPR_USE_SYSTEM_CURL=ON \
    -DCPR_BUILD_TESTS=OFF \
    -DCPR_GENERATE_COVERAGE=OFF \
    -DCPR_USE_SYSTEM_GTEST=ON \
    -DCPR_CURL_NOSIGNAL=OFF \
    -DCPR_FORCE_DARWINSSL_BACKEND=OFF \
    -DCPR_FORCE_OPENSSL_BACKEND=ON \
    -DCPR_FORCE_WINSSL_BACKEND=OFF \
    -DCMAKE_USE_OPENSSL=ON \
    -DCPR_ENABLE_SSL=ON \
&& \
cmake --build . --parallel=`nproc` \
&& \
cmake --install .
