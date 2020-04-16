# action-clang-format - A GitHub action to check a directory using clang-format

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Runs [clang-format](https://clang.llvm.org/docs/ClangFormat.html) recursively on files in a directory and reports errors using a diff. Can use a [.clang-format](https://clang.llvm.org/docs/ClangFormatStyleOptions.html) file for style (when using style: 'file').

If you find a bug or make an improvement your pull requests are appreciated.

## License

All of this is under the [MIT License](LICENSE).

## Usage

Create a new workflow file, e.g. ./github/workflows/clang-format.yml:

```yaml
# Run clang-format
name: Clang-format

on:
  push:
    branches: [ master ]
  pull_request:
    branches: [ master ]

jobs:
  checkout-and-check-formatting:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v2
    - name: Run clang-format
      uses: HorstBaerbel/action-clang-format@master
      # These are optional (defaults displayed)
      with:
        scandir: '.'
        excludedirs: 'build'
        extensions: 'c,h,C,H,cpp,hpp,cc,hh,c++,h++,cxx,hxx'
        style: 'file'
```

## Parameters

* **scandir**: Directory to scan, e.g. '/bla'.
* **excludedirs**: Directories below scandir to exclude from scanning, e.g. "build,test,src/third_party".
* **extensions**: Extensions to include in scan, e.g. 'h,c,hpp,cpp'.
* **style**: Style string to pass to clang-format. Use 'file' to make clang-format use a [.clang-format](https://clang.llvm.org/docs/ClangFormatStyleOptions.html) file.
