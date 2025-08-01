#!/bin/bash

set -e

do_clean=0
do_pkg_list=()

while [[ $# -gt 0 ]]; do
    case $1 in
        -h)
            echo
            echo "Usage: build.sh [options] [target] ..."
            echo
            echo "Build Options:"
            echo "  -c         remove build files then exit"
            echo "  -h         print command line options"
            echo
            exit 0
            ;;
         -c) do_clean=1 && shift ;;
         -*) echo "Unknown option: $1" && exit 1 ;;
          *) do_pkg_list+=($1) && shift ;;
    esac
done

if [ ${#do_pkg_list[@]} -eq 0 ]; then
    do_pkg_list=(
        "zlib"
        "zstd"
        "libiconv"
        "openssl"
        "imgui"
        "glfw"
        "libjpeg"
        "libpng"
        "libwebp"
        "libtiff"
        "openjpeg"
        "boost"
        "libuv"
        "usockets"
        "uwebsockets"
        "curl"
        "libcpr"
        "catch2"
        "fmt"
        "spdlog"
        "gflags"
        "gtest"
        "glog"
        "nlohmann-json"
        "thread-pool"
        "concurrent-queue"
        "sqlite3"
        "yaml-cpp"
        "leveldb"
        "tinyxml2"
        # "openexr"
        "opencv"
        "xxd"
        "sentencepiece"
        "gnuplot-iostream"
        "pegtl"
    )
fi

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
export TC_TOOLCHAIN_DIR=$script_dir/..

if [ $do_clean -eq 1 ]; then
    for pkg in "${do_pkg_list[@]}"
    do
        pkg_dir=$script_dir/$pkg
        if [ ! -d "$pkg_dir" ]; then
            echo "'$pkg' target not found!"
            exit 1
        fi

        rm -rf $pkg_dir/src
        rm -rf $pkg_dir/out
    done
    exit 0
fi

echo "start" && \
for pkg in "${do_pkg_list[@]}"
do
    pkg_dir=$script_dir/$pkg
    if [ ! -d "$pkg_dir" ]; then
        echo "'$pkg' target not found!"
        exit 1
    fi

    echo "$pkg start"
    $pkg_dir/build.sh -c || exit 1
    echo "$pkg done"
done \
&& echo "done"
