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
SOURCE_DIR=dcmtk-DCMTK-3.6.7

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
    -DBUILD_TESTING=OFF \
    -DBUILD_SINGLE_SHARED_LIBRARY=OFF \
    -DDCMTK_ENABLE_CXX11=ON \
    -DDCMTK_ENABLE_STL=ON \
    -DDCMTK_NO_TRY_RUN=TRUE \
    -DDCMTK_ICONV_FLAGS_ANALYZED=ON \
    -DDCMTK_ENABLE_CHARSET_CONVERSION=libiconv \
    -DHAVE_STL_VECTOR_TEST_RESULT=1 \
    -DHAVE_STL_ALGORITHM_TEST_RESULT=1 \
    -DHAVE_STL_LIMITS_TEST_RESULT=1 \
    -DHAVE_STL_LIST_TEST_RESULT=1 \
    -DHAVE_STL_MAP_TEST_RESULT=1 \
    -DHAVE_STL_MEMORY_TEST_RESULT=1 \
    -DHAVE_STL_STACK_TEST_RESULT=1 \
    -DHAVE_STL_STRING_TEST_RESULT=1 \
    -DHAVE_STL_TYPE_TRAITS_TEST_RESULT=1 \
    -DHAVE_STL_TUPLE_TEST_RESULT=1 \
    -DHAVE_STL_SYSTEM_ERROR_TEST_RESULT=1 \
&& \
cp ../patches/arith.h ./config/include/dcmtk/config/ \
&& \
cmake --build . --parallel=`nproc` \
&& \
cmake --install .
