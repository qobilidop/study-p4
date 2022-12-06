#!/usr/bin/env bash
# https://github.com/p4lang/PI/blob/main/Dockerfile
set -ex

cd PI
./autogen.sh
./configure --enable-Werror --without-bmv2 --without-internal-rpc --without-cli --with-proto --with-sysrepo
make -j"$(nproc)"
make install
sudo ldconfig
