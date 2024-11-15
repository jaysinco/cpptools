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
SOURCE_DIR=opencv-4.8.1
SOURCE_CONTRIB_DIR=opencv_contrib-4.8.1

if [ $do_clean -eq 1 ]; then
    rm -rf $SCRIPT_DIR/src
    rm -rf $SCRIPT_DIR/out
fi

if [ ! -d $SCRIPT_DIR/src/$SOURCE_DIR ]; then
    mkdir -p $SCRIPT_DIR/src
    tar -xzf $TC_SOURCE_REPO/$SOURCE_DIR.tar.gz -C $SCRIPT_DIR/src
fi

if [ ! -d $SCRIPT_DIR/src/$SOURCE_CONTRIB_DIR ]; then
    mkdir -p $SCRIPT_DIR/src
    tar -xzf $TC_SOURCE_REPO/$SOURCE_CONTRIB_DIR.tar.gz -C $SCRIPT_DIR/src
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
    -DBUILD_DOCS=OFF \
    -DBUILD_EXAMPLES=OFF \
    -DBUILD_TESTS=OFF \
    -DBUILD_PACKAGE=OFF \
    -DBUILD_PERF_TESTS=OFF \
    -DBUILD_USE_SYMLINKS=OFF \
    -DBUILD_opencv_apps=ON \
    -DBUILD_opencv_java=OFF \
    -DBUILD_opencv_java_bindings_gen=OFF \
    -DBUILD_opencv_js=OFF \
    -DBUILD_opencv_python2=OFF \
    -DBUILD_opencv_python3=OFF \
    -DBUILD_opencv_python_bindings_g=OFF \
    -DBUILD_opencv_python_tests=OFF \
    -DBUILD_opencv_ts=OFF \
    -DBUILD_opencv_wechat_qrcode=OFF \
    -DBUILD_opencv_xfeatures2d=OFF \
    -DBUILD_opencv_face=OFF \
    -DOPENCV_FORCE_3RDPARTY_BUILD=OFF \
    -DOPENCV_PYTHON_SKIP_DETECTION=ON \
    -DOPENCV_MODULES_PUBLIC="opencv" \
    -DOPENCV_EXTRA_MODULES_PATH=$SCRIPT_DIR/src/$SOURCE_CONTRIB_DIR/modules \
    -DENABLE_PIC=ON \
    -DWITH_ADE=OFF \
    -DWITH_IPP=OFF \
    -DWITH_OPENEXR=OFF \
&& \
cmake --build . --parallel=`nproc` \
&& \
cmake --install .
