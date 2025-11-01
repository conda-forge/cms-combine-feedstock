#!/bin/bash
set -ex

# When cross-compiling, we cannot get the host python sitelib, only the build one
# But at least they will have the same version
Python_SITELIB=$PREFIX$(python3 -c "import sysconfig;p=sysconfig.get_path('purelib');print(p[p.rfind('/lib'):])")
cmake ${CMAKE_ARGS} -DCMAKE_INSTALL_PYTHONDIR=$Python_SITELIB -S HiggsAnalysis/CombinedLimit -B build
if [[ "${target_platform}" == "osx-arm64" && "${CONDA_BUILD_CROSS_COMPILATION}" == "1" ]]; then
  echo "Hack to use rootcling from BUILD_PREFIX"
  sed -i "s#/bin/cmake -E env .*/bin/rootcling#/bin/rootcling#" build/CMakeFiles/HiggsAnalysisCombinedLimit.dir/build.make
fi
cmake --build build --clean-first --parallel="${CPU_COUNT}"
cmake --install build
