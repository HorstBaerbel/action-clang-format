#!/bin/bash

# Terminate upon errors
set -e
# Run format script
clang-format --version
python3 /run-clang-format.py "${INPUT_SCANDIR}" "${INPUT_EXCLUDEDIRS}" "${INPUT_EXTENSIONS}" "${INPUT_STYLE}"
