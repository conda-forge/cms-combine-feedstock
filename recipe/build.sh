#!/bin/bash
set -ex

# When cross-compiling, we cannot get the host python sitelib, only the build one
# But at least they will have the same version
Python_SITELIB=$PREFIX$(python3 -c "import sysconfig;p=sysconfig.get_path('purelib');print(p[p.rfind('/lib'):])")
cmake ${CMAKE_ARGS} -DPython_SITELIB=$Python_SITELIB -S HiggsAnalysis/CombinedLimit -B build
cmake -LAH build
cmake --build build --clean-first --parallel="${CPU_COUNT}"
cmake --install build
