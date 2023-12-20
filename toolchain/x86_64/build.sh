#!/bin/bash

set -e

do_clean=0

while [[ $# -gt 0 ]]; do
    case $1 in
        -h)
            echo
            echo "Usage: build.sh [options]"
            echo
            echo "Build Options:"
            echo "  -c         remove build files then exit"
            echo "  -h         print command line options"
            echo
            exit 0
            ;;
         -c) do_clean=1 && shift ;;
          *) echo "Unknown option: $1" && exit 1 ;;
    esac
done

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

pushd $script_dir/crosstool
ct-ng clean
if [ $do_clean -eq 1 ]; then
    exit 0
fi
ct-ng build
