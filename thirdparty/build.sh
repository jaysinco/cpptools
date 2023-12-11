#!/bin/bash

set -e

do_pkg_all=0
do_arch=x86_64
do_pkg_list=()

while [[ $# -gt 0 ]]; do
    case $1 in
        -h)
            echo
            echo "Usage: build.sh [options] [target] ..."
            echo
            echo "Build Options:"
            echo "  -a         build all targets"
            echo "  -t ARCH    build toolchain, default 'x86_64'"
            echo "  -h         print command line options"
            echo
            exit 0
            ;;
         -a) do_pkg_all=1 && shift ;;
         -t) do_arch=$2 && shift && shift ;;
         -*) echo "Unknown option: $1" && exit 1 ;;
          *) do_pkg_list+=($1) && shift ;;
    esac
done

if [ $do_pkg_all -eq 1 ]; then
    do_pkg_list=(
        "zlib"
        "zstd"
        "libiconv"
        "openssl"
        "catch2"
        "fmt"
        "spdlog"
        "curl"
    )
fi

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
export TC_TOOLCHAIN_DIR=$SCRIPT_DIR/../toolchain/$do_arch

if [ ! -d "$TC_TOOLCHAIN_DIR" ]; then
    echo "'$do_arch' toolchain not found!"
    exit 1
fi

echo "$do_arch start" && \
for pkg in "${do_pkg_list[@]}"
do
    pkg_script=$SCRIPT_DIR/$pkg/build.sh
    if [ ! -f "$pkg_script" ]; then
        echo "'$pkg' target not found!"
        exit 1
    fi

    echo "$pkg start"
    $pkg_script -c || exit 1
    echo "$pkg done"
done \
&& echo "$do_arch done"
