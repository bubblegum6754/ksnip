#!/bin/bash

# Same as .github/scripts/setup_kImageAnnotator.sh, but takes kImageAnnotator from
# the repository and branch in KIA_REPO and KIA_BRANCH, so changes that are not
# released yet can be tested. Only used by the fork test workflow.

set -e

echo "Building ksnip with kImageAnnotator from ${KIA_REPO} at ${KIA_BRANCH}"
git clone --depth 1 --branch "${KIA_BRANCH}" "https://github.com/${KIA_REPO}.git" kImageAnnotator

cd kImageAnnotator
git log --oneline -1

mkdir build && cd build
cmake .. -G"${CMAKE_GENERATOR}" -DCMAKE_BUILD_TYPE="${BUILD_TYPE}" -DBUILD_EXAMPLE=OFF -DCMAKE_INSTALL_PREFIX="${INSTALL_PREFIX}" -DCMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES="${INSTALL_PREFIX}/include" -DBUILD_WITH_QT6="${USE_QT6}"
${MAKE_BINARY} && ${MAKE_BINARY} install
