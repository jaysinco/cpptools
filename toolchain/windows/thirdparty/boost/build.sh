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
SOURCE_DIR=boost-1.82.0

if [ $do_clean -eq 1 ]; then
    rm -rf $SCRIPT_DIR/src
    rm -rf $SCRIPT_DIR/out
fi

if [ ! -d $SCRIPT_DIR/src/$SOURCE_DIR ]; then
    mkdir -p $SCRIPT_DIR/src
    tar -xf $TC_SOURCE_REPO/$SOURCE_DIR.tar.xz -C $SCRIPT_DIR/src
fi

export BOOST_BUILD_PATH=$SCRIPT_DIR

pushd $SCRIPT_DIR/src/$SOURCE_DIR \
&& \
if [ ! -f "./b2" ]; then \
    ./bootstrap.bat --without-libraries=python
fi \
&& \
./b2 \
    variant=release \
    runtime-link=shared \
    link=shared \
    architecture=x86 \
    address-model=64 \
    toolset=msvc \
    threading=multi \
    cxxflags="" \
    linkflags="" \
    --without-python \
    -j`nproc` \
    --abbreviate-paths \
    --layout=system \
    --debug-configuration \
    --build-dir=$SCRIPT_DIR/out \
    --prefix=$TC_INSTALL_DIR \
    install \
&& \
mv $TC_INSTALL_DIR/lib/boost_*.dll $TC_INSTALL_DIR/bin
