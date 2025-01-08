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
SOURCE_DIR=openssl-1.1.1w

if [ $do_clean -eq 1 ]; then
    rm -rf $SCRIPT_DIR/src
    rm -rf $SCRIPT_DIR/out
fi

if [ ! -d $SCRIPT_DIR/src/$SOURCE_DIR ]; then
    mkdir -p $SCRIPT_DIR/src
    tar -xzf $TC_SOURCE_REPO/$SOURCE_DIR.tar.gz -C $SCRIPT_DIR/src
fi

vc_path=$(dirname "$(which cl)")
perl_path=`which -a perl | grep -i strawberry`
echo "using perl from $perl_path"

mkdir -p $SCRIPT_DIR/out \
&& \
pushd $SCRIPT_DIR/out \
&& \
$perl_path $SCRIPT_DIR/src/$SOURCE_DIR/Configure \
    VC-WIN64A \
    shared \
    --prefix=$TC_INSTALL_DIR \
    --openssldir=$TC_INSTALL_DIR \
    no-unit-test \
    threads \
    no-tests \
    --release \
    zlib-dynamic \
    --with-zlib-include="$TC_INSTALL_DIR/include" \
    --with-zlib-lib="$TC_INSTALL_DIR/bin/zlib1.dll" \
&& \
PATH="$vc_path:$PATH" nmake \
&& \
PATH="$vc_path:$PATH" nmake install_sw
