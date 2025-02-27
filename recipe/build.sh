#!/bin/bash
set -ex

pushd HiggsAnalysis/CombinedLimit
mkdir build
cd build
cmake ..
make -j${CPU_COUNT}
make install
popd
