#!/bin/bash
set -ex

pushd HiggsAnalysis/CombinedLimit
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=$PREFIX ..
make -j${CPU_COUNT}
make install
popd
