#!/bin/bash

set -e

TC_ARCH=x86_64
TC_HOST_ARCH=`arch`

TC_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
TC_ROOT_DIR=$TC_SCRIPT_DIR/../..
TC_SOURCE_REPO=$TC_ROOT_DIR/src
TC_HOST_COMPILER_TUPLE=$TC_HOST_ARCH-linux-gnu
TC_COMPILER_TUPLE=$TC_ARCH-unknown-linux-gnu
TC_COMPILER_DIR=$TC_SCRIPT_DIR/$TC_COMPILER_TUPLE
TC_COMPILER_BINDIR=$TC_COMPILER_DIR/bin
TC_COMPILER_CC=$TC_COMPILER_BINDIR/$TC_COMPILER_TUPLE-gcc
TC_COMPILER_CXX=$TC_COMPILER_BINDIR/$TC_COMPILER_TUPLE-g++
TC_SYSROOT=$TC_COMPILER_DIR/$TC_COMPILER_TUPLE/sysroot
TC_CMAKE_TOOLCHAIN=$TC_SCRIPT_DIR/toolchain.cmake
TC_MESON_CROSSFILE=$TC_SCRIPT_DIR/meson-crossfile.ini

export PATH="$PATH:$TC_COMPILER_BINDIR"
export TC_COMPILER_CC=$TC_COMPILER_CC
export TC_COMPILER_CXX=$TC_COMPILER_CXX
export TC_SYSROOT=$TC_SYSROOT
export TC_INSTALL_DIR=$TC_SYSROOT/usr
