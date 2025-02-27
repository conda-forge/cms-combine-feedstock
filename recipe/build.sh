#!/bin/bash
set -ex

python3 -c "import sysconfig; print(sysconfig.get_path('platlib'))"
cmake ${CMAKE_ARGS} -DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_PREFIX_PATH=$PREFIX -S HiggsAnalysis/CombinedLimit -B build
cmake -LH build
cmake --build build --clean-first --parallel="${CPU_COUNT}"
cmake --install build
