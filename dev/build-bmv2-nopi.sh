#!/usr/bin/env bash
# https://github.com/p4lang/behavioral-model/blob/main/Dockerfile.noPI
set -ex

cd behavioral-model
./autogen.sh
./configure -enable-debugger
make -j"$(nproc)"
make install
sudo ldconfig
