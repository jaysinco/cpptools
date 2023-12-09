#!/bin/bash

set -e

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

pushd $script_dir \
&& \
ct-ng clean \
&& \
ct-ng build
