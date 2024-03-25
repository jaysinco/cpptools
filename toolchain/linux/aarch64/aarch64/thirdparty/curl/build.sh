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
SOURCE_DIR=curl-7.88.1

if [ $do_clean -eq 1 ]; then
    rm -rf $SCRIPT_DIR/src
    rm -rf $SCRIPT_DIR/out
fi

if [ ! -d $SCRIPT_DIR/src/$SOURCE_DIR ]; then
    mkdir -p $SCRIPT_DIR/src
    tar -xf $TC_SOURCE_REPO/$SOURCE_DIR.tar.xz -C $SCRIPT_DIR/src
fi

mkdir -p $SCRIPT_DIR/out \
&& \
pushd $SCRIPT_DIR/out \
&& \
cmake ../src/$SOURCE_DIR -G "Unix Makefiles" \
    -DCMAKE_TOOLCHAIN_FILE=$TC_CMAKE_TOOLCHAIN \
    -DCMAKE_INSTALL_PREFIX=$TC_INSTALL_DIR \
    -DCMAKE_FIND_ROOT_PATH=$TC_INSTALL_DIR \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
    -DBUILD_SHARED_LIBS=ON \
    -DBUILD_TESTING=OFF \
    -DBUILD_CURL_EXE=ON \
    -DCURL_DISABLE_LDAP=ON \
    -DCURL_STATICLIB=OFF \
    -DCURL_USE_SCHANNEL=OFF \
    -DCURL_USE_OPENSSL=ON \
    -DCURL_USE_WOLFSSL=OFF \
    -DUSE_NGHTTP2=OFF \
    -DCURL_ZLIB=ON \
    -DCURL_BROTLI=OFF \
    -DCURL_ZSTD=ON \
    -DCURL_USE_LIBSSH2=OFF \
    -DENABLE_ARES=OFF \
    -DCURL_DISABLE_PROXY=OFF \
    -DCURL_DISABLE_RTSP=OFF \
    -DCURL_DISABLE_CRYPTO_AUTH=OFF \
    -DCURL_DISABLE_VERBOSE_STRINGS=OFF \
    -DNTLM_WB_ENABLED=ON \
    -DCURL_CA_BUNDLE=none \
    -DCURL_CA_PATH=none \
&& \
cmake --build . --parallel=`nproc` \
&& \
cmake --install .
