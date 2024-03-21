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
SOURCE_DIR=sqlite-amalgamation-3440200

if [ $do_clean -eq 1 ]; then
    rm -rf $SCRIPT_DIR/src
    rm -rf $SCRIPT_DIR/out
fi

if [ ! -d $SCRIPT_DIR/src/$SOURCE_DIR ]; then
    mkdir -p $SCRIPT_DIR/src
    unzip $TC_SOURCE_REPO/$SOURCE_DIR.zip -d $SCRIPT_DIR/src
    cp $SCRIPT_DIR/patches/CMakeLists.txt $SCRIPT_DIR/src/$SOURCE_DIR/
fi

mkdir -p $SCRIPT_DIR/out \
&& \
pushd $SCRIPT_DIR/out \
&& \
cmake ../src/$SOURCE_DIR -G "Ninja" \
    -DCMAKE_TOOLCHAIN_FILE=$TC_CMAKE_TOOLCHAIN \
    -DCMAKE_INSTALL_PREFIX=$TC_INSTALL_DIR \
    -DCMAKE_FIND_ROOT_PATH=$TC_INSTALL_DIR \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_MSVC_RUNTIME_LIBRARY="MultiThreadedDLL" \
    -DBUILD_SHARED_LIBS=ON \
    -DSQLITE3_SRC_DIR="$SCRIPT_DIR/src/$SOURCE_DIR" \
    -DSQLITE3_VERSION="3.44.2" \
    -DSQLITE3_BUILD_EXECUTABLE=ON \
    -DTHREADSAFE=1 \
    -DENABLE_COLUMN_METADATA=ON \
    -DENABLE_DBSTAT_VTAB=OFF \
    -DENABLE_EXPLAIN_COMMENTS=OFF \
    -DENABLE_FTS3=OFF \
    -DENABLE_FTS3_PARENTHESIS=OFF \
    -DENABLE_FTS4=OFF \
    -DENABLE_FTS5=OFF \
    -DENABLE_JSON1=OFF \
    -DENABLE_PREUPDATE_HOOK=OFF \
    -DENABLE_SOUNDEX=OFF \
    -DENABLE_RTREE=ON \
    -DENABLE_UNLOCK_NOTIFY=ON \
    -DENABLE_DEFAULT_SECURE_DELETE=OFF \
    -DUSE_ALLOCA=OFF \
    -DOMIT_LOAD_EXTENSION=OFF \
    -DOMIT_DEPRECATED=OFF \
    -DENABLE_MATH_FUNCTIONS=ON \
    -DHAVE_FDATASYNC=ON \
    -DHAVE_GMTIME_R=ON \
    -DHAVE_LOCALTIME_R=OFF \
    -DHAVE_POSIX_FALLOCATE=OFF \
    -DHAVE_STRERROR_R=ON \
    -DHAVE_USLEEP=ON \
    -DDISABLE_GETHOSTUUID=OFF \
    -DDISABLE_DEFAULT_VFS=OFF \
    -DENABLE_DBPAGE_VTAB=OFF \
&& \
cmake --build . --parallel=`nproc` \
&& \
cmake --install .
