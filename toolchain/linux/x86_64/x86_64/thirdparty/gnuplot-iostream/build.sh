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
SOURCE_DIR=gnuplot-iostream-2025.05.16

if [ $do_clean -eq 1 ]; then
    rm -rf $SCRIPT_DIR/src
    rm -rf $SCRIPT_DIR/out
fi

if [ ! -d $SCRIPT_DIR/src/$SOURCE_DIR ]; then
    mkdir -p $SCRIPT_DIR/src
    unzip -q $TC_SOURCE_REPO/$SOURCE_DIR.zip -d $SCRIPT_DIR/src
fi

pushd $SCRIPT_DIR/src/gnuplot-iostream-master \
&& \
mkdir -p $TC_INSTALL_DIR/include/ \
&& \
cp gnuplot-iostream.h $TC_INSTALL_DIR/include/
