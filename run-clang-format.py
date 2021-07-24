#!/usr/bin/env python

# Run clang-format recursively and parallel on directory
# Usage: run-clang-format sourcedir excludedirs extensions style
# extensions and excludedirs are specified as comma-separated 
# string without dot, e.g. 'c,cpp'
# e.g. run-clang-format . build,test c,cpp file

import os, sys, subprocess, multiprocessing
manager = multiprocessing.Manager()
failedfiles = manager.list()

# Get absolute current path and remove trailing seperators
currentdir = os.path.realpath(os.getcwd()).rstrip(os.sep)
print("Arguments: " + str(sys.argv))
# Get absolute source dir after removing leading and trailing seperators from input. 
sourcedir = os.path.join(currentdir,sys.argv[1].lstrip(os.sep).rstrip(os.sep))
print("Source directory: " + sourcedir)
excludedirs = ()
if sys.argv[2]:
    excludedirs = tuple([(sourcedir + os.sep + s).rstrip(os.sep) for s in sys.argv[2].split(',')])
print("Exclude directories: " + str(excludedirs))
extensions = tuple([("." + s) for s in sys.argv[3].split(',')])
print("Extensions: " + str(extensions))
style = sys.argv[4]
print("Style: " + style)

def runclangformat(filepath):
    print("Checking: " + filepath)
    # See: https://stackoverflow.com/questions/22866609/can-clang-format-tell-me-if-formatting-changes-are-necessary
    proc = subprocess.Popen("clang-format -style=" + style + " " + filepath + " | diff -u --color=always " + filepath + " -", shell=True)
    if proc.wait() != 0:
        failedfiles.append(filepath)

def collectfiles(dir, exclude, exts):
    collectedfiles = []
    for root, dirs, files in os.walk(dir):
        for file in files:
            filepath = root + os.sep + file
            if (len(exclude) == 0 or not filepath.startswith(exclude)) and filepath.endswith(exts):
                collectedfiles.append(filepath)
    return collectedfiles

# Define the pool AFTER the global variables and subprocess function because WTF python
# See: https://stackoverflow.com/questions/41385708/multiprocessing-example-giving-attributeerror
pool = multiprocessing.Pool()
pool.map(runclangformat, collectfiles(sourcedir, excludedirs, extensions))
pool.close()
pool.join()
if len(failedfiles) > 0:
    print("Errors in " + str(len(failedfiles)) + " files")
    sys.exit(1)
print("No errors found")
sys.exit(0)
