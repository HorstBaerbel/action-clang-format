#!/bin/sh -l

# Terminate upon errors
set -e
# Run format script
python3 /run-clang-format.py ${INPUT_SCANDIR} ${INPUT_EXCLUDEDIRS} ${INPUT_EXTENSIONS} ${INPUT_STYLE}