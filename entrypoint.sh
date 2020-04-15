#!/bin/sh
# Terminate upon errors
set -e
# Run format script
python ./run-clang-format-py $1 $2