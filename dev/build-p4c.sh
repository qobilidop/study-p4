#!/usr/bin/env bash
# https://github.com/p4lang/p4c/blob/main/tools/ci-build.sh
set -ex

cd p4c
mkdir -p build
cd build
cmake ..
make -j"$(nproc)"
make install
sudo ldconfig
