# action-clang-format - Check repository using clang-format

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Installs [clang-format](https://clang.llvm.org/docs/ClangFormat.html) and runs it (with -style=file) recursively on all header and source files in the directory specified with "sourcedir", excluding the directory "excludedir" and reports errors. Uses a [.clang-format](https://clang.llvm.org/docs/ClangFormatStyleOptions.html) file for style.

If you find a bug or make an improvement your pull requests are appreciated.

# License

All of this is under the [MIT License](LICENSE).

# Usage

* Make sure you have a .clang-format file in the path you want to run the action on.
* Create a new workflow file, e.g. ./github/workflows/clang-format.yml:

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
      # These are optional
      with:
        sourcedir: '.'
        excludedir: './build'
```
