#!/bin/bash
set -ex

realpath $PREFIX
ls $PREFIX/bin
ls $PREFIX/lib/python*
cmake ${CMAKE_ARGS} -DPython_ROOT_DIR=$PREFIX -S HiggsAnalysis/CombinedLimit -B build
cmake -LH build
cmake --build build --clean-first --parallel="${CPU_COUNT}"
cmake --install build
