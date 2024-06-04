#!/bin/bash

set -e

TC_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
TC_ROOT_DIR=$TC_SCRIPT_DIR/../../../..
TC_SOURCE_REPO=$TC_ROOT_DIR/src

TC_CROSS_COMPILE=0
TC_SYSROOT=$TC_SCRIPT_DIR/sysroot
TC_INSTALL_DIR=$TC_SYSROOT
TC_THIRDPARTY=$TC_SCRIPT_DIR/thirdparty
