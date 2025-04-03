#!/bin/bash
set -ex

# if [[ "${target_platform}" =~ "aarch64" ]]; then
#   export CFLAGS="${CFLAGS//-march=nocona/}"
#   export CFLAGS="${CFLAGS//-mtune=haswell/} -march=native -mtune=generic"
#   export CXXFLAGS="${CXXFLAGS//-march=nocona/}"
#   export CXXFLAGS="${CXXFLAGS//-mtune=haswell/} -march=native -mtune=generic"
#   export LDFLAGS="${LDFLAGS}"
# fi

# When cross-compiling, we cannot get the host python sitelib, only the build one
# But at least they will have the same version
Python_SITELIB=$PREFIX$(python3 -c "import sysconfig;p=sysconfig.get_path('purelib');print(p[p.rfind('/lib'):])")
cmake ${CMAKE_ARGS} -DPython_SITELIB=$Python_SITELIB -S HiggsAnalysis/CombinedLimit -B build
if [[ "${target_platform}" == "osx-arm64" && "${CONDA_BUILD_CROSS_COMPILATION}" == "1" ]]; then
  echo "Hack to use rootcling from BUILD_PREFIX"
  sed -i "s#/bin/cmake -E env .*/bin/rootcling#/bin/rootcling#" build/CMakeFiles/HiggsAnalysisCombinedLimit.dir/build.make
fi
cmake --build build --clean-first --parallel="${CPU_COUNT}"
cmake --install build
