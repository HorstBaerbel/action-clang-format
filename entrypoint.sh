#!/bin/sh -l

# Terminate upon errors
set -e
# Run format script
python3 /run-clang-format.py ${INPUT_SOURCEDIR} ${INPUT_EXCLUDEDIR}