#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

echo "start!" \
&& $SCRIPT_DIR/zlib/build.sh -c \
&& $SCRIPT_DIR/zstd/build.sh -c \
&& $SCRIPT_DIR/libiconv/build.sh -c \
&& $SCRIPT_DIR/openssl/build.sh -c \
&& $SCRIPT_DIR/catch2/build.sh -c \
&& $SCRIPT_DIR/fmt/build.sh -c \
&& $SCRIPT_DIR/spdlog/build.sh -c \
&& $SCRIPT_DIR/curl/build.sh -c \
&& echo "done!"
