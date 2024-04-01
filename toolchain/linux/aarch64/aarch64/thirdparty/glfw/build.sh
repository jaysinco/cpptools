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
SOURCE_DIR=glfw-3.3.9

if [ $do_clean -eq 1 ]; then
    rm -rf $SCRIPT_DIR/src
    rm -rf $SCRIPT_DIR/out
fi

if [ ! -d $SCRIPT_DIR/src/$SOURCE_DIR ]; then
    mkdir -p $SCRIPT_DIR/src
    tar -xzf $TC_SOURCE_REPO/$SOURCE_DIR.tar.gz -C $SCRIPT_DIR/src
fi

if [ ! -f "/usr/share/ECM/cmake/ECMConfig.cmake" ]; then
    echo "-- install ecm"
    sudo apt-get -y install extra-cmake-modules
fi

if [ ! -f "/usr/include/X11/extensions/Xrandr.h" ]; then
    echo "-- install libxrandr-dev"
    sudo apt-get -y install libxrandr-dev
fi

if [ ! -f "/usr/include/X11/extensions/Xinerama.h" ]; then
    echo "-- install libxinerama-dev"
    sudo apt-get -y install libxinerama-dev
fi

if [ ! -f "/usr/include/X11/extensions/XInput.h" ]; then
    echo "-- install libxi-dev"
    sudo apt-get -y install libxi-dev
fi

mkdir -p $SCRIPT_DIR/out \
&& \
pushd $SCRIPT_DIR/out \
&& \
cmake ../src/$SOURCE_DIR -G "Unix Makefiles" \
    -DCMAKE_C_COMPILER=gcc \
    -DCMAKE_CXX_COMPILER=g++ \
    -DCMAKE_INSTALL_PREFIX=$TC_INSTALL_DIR \
    -DCMAKE_FIND_ROOT_PATH=$TC_INSTALL_DIR \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
    -DBUILD_SHARED_LIBS=ON \
    -DECM_DIR="/usr/share/ECM/cmake" \
    -DGLFW_BUILD_EXAMPLES=ON \
    -DGLFW_BUILD_TESTS=OFF \
    -DGLFW_BUILD_DOCS=OFF \
&& \
cmake --build . --parallel=`nproc` \
&& \
cmake --install .
