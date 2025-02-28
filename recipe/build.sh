#!/bin/bash
set -ex

cmake ${CMAKE_ARGS} -DPython_SITELIB=$(python3 -c "import sysconfig; print(sysconfig.get_path('purelib'))") -S HiggsAnalysis/CombinedLimit -B build
cmake -LH build
cmake --build build --clean-first --parallel="${CPU_COUNT}"
cmake --install build
