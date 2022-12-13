#!/usr/bin/env bash
# https://github.com/p4lang/p4-dpdk-target#building-and-installing
# https://github.com/p4lang/p4-dpdk-target/blob/main/.github/workflows/build_p4sde_ci.yml
set -ex

[ -z "$SDE" ] && echo "Environment variable SDE not set" && exit 1
[ -z "$SDE_INSTALL" ] && echo "Environment variable SDE_INSTALL not set" && exit 1
echo "Using SDE: $SDE"
echo "Using SDE_INSTALL: $SDE_INSTALL"
mkdir -p "$SDE_INSTALL"

#  https://github.com/p4lang/p4-dpdk-target/blob/main/tools/setup/p4sde_env_setup.sh
export LD_LIBRARY_PATH="$SDE_INSTALL/lib:$SDE_INSTALL/lib64:$SDE_INSTALL/lib/x86_64-linux-gnu/"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib64"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"
echo "Using LD_LIBRARY_PATH: $LD_LIBRARY_PATH"

cd p4-dpdk-target
./autogen.sh
./configure --prefix="$SDE_INSTALL"
make -j
make install
sudo ldconfig
