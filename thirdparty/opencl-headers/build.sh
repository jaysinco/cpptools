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
SOURCE_DIR_C=OpenCL-Headers-2023.12.14
SOURCE_DIR_CPP=OpenCL-CLHPP-2023.12.14

if [ $do_clean -eq 1 ]; then
    rm -rf $SCRIPT_DIR/src
    rm -rf $SCRIPT_DIR/out
fi

if [ ! -d $SCRIPT_DIR/src/$SOURCE_DIR_C ]; then
    mkdir -p $SCRIPT_DIR/src
    tar -xzf $TC_SOURCE_REPO/$SOURCE_DIR_C.tar.gz -C $SCRIPT_DIR/src
fi

if [ ! -d $SCRIPT_DIR/src/$SOURCE_DIR_CPP ]; then
    mkdir -p $SCRIPT_DIR/src
    tar -xzf $TC_SOURCE_REPO/$SOURCE_DIR_CPP.tar.gz -C $SCRIPT_DIR/src
fi

mkdir -p $TC_INSTALL_DIR/include/CL \
&& \
pushd $SCRIPT_DIR/src/$SOURCE_DIR_C \
&& \
cp CL/* $TC_INSTALL_DIR/include/CL \
&& \
pushd $SCRIPT_DIR/src/$SOURCE_DIR_CPP \
&& \
cp include/CL/* $TC_INSTALL_DIR/include/CL
