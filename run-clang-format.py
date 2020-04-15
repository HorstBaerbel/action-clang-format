# Run clang-format recursively and parallel on directory
# Usage: run-clang-format sourcedir excludedir

import os, sys, subprocess, multiprocessing
manager = multiprocessing.Manager()
failedfiles = manager.list()

extensions = (".cpp", ".cxx", ".c++", ".cc", ".cp", ".c", ".i", ".ii", ".h", ".h++", ".hpp", ".hxx", ".hh", ".inl", ".inc", ".ipp", ".ixx", ".txx", ".tpp", ".tcc", ".tpl")
print("Source directory: " + sys.argv[1])
print("Exclude directory: " + sys.argv[2])

def runclangformat(filepath):
    print("Checking: " + filepath)
    # See: https://stackoverflow.com/questions/22866609/can-clang-format-tell-me-if-formatting-changes-are-necessary
    proc = subprocess.Popen("clang-format -style=file " + filepath + " | diff -u --color=always " + filepath + " -", shell=True)
    if proc.wait() != 0:
        failedfiles.append(filepath)

def collectfiles(dir, excludedir, extensions):
    collectedfiles = []
    for root, dirs, files in os.walk(dir):
        for file in files:
            filepath = root + "/" + file
            if (excludedir == "" or not filepath.startswith(excludedir)) and filepath.endswith(extensions):
                collectedfiles.append(filepath)
    return collectedfiles

# Define the pool AFTER the global variables and subprocess function because WTF python
# See: https://stackoverflow.com/questions/41385708/multiprocessing-example-giving-attributeerror
pool = multiprocessing.Pool()
pool.map(runclangformat, collectfiles(sys.argv[1], sys.argv[2], extensions))
pool.close()
pool.join()
sys.exit(1 if len(failedfiles) > 0 else 0)
