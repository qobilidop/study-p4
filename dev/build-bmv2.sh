#!/usr/bin/env bash
# https://github.com/p4lang/behavioral-model/blob/main/Dockerfile
set -ex

cd behavioral-model
./autogen.sh
./configure --with-pdfixed --with-pi --with-stress-tests --enable-debugger --enable-coverage --enable-Werror
make -j"$(nproc)"
make install
sudo ldconfig
