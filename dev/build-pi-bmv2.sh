#!/usr/bin/env bash
# https://github.com/p4lang/PI/blob/main/Dockerfile.bmv2
set -ex

cd PI
./autogen.sh
./configure --enable-Werror --with-bmv2 --with-proto --with-cli --with-internal-rpc --with-sysrepo
make -j"$(nproc)"
make install
sudo ldconfig
