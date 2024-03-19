#!/bin/bash

set -e

TC_ARCH=x86_64
TC_HOST_ARCH=`arch`

TC_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
TC_ROOT_DIR=$TC_SCRIPT_DIR/../../..
TC_SOURCE_REPO=$TC_ROOT_DIR/src
TC_SYSROOT=$TC_COMPILER_DIR/$TC_COMPILER_TUPLE/sysroot
TC_CMAKE_TOOLCHAIN=$TC_SCRIPT_DIR/toolchain.cmake

export TC_SYSROOT=$TC_SYSROOT
export TC_INSTALL_DIR=$TC_SYSROOT/usr
export TC_THIRDPARTY=$TC_SCRIPT_DIR/../thirdparty
