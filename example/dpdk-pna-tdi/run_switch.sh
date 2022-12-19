#!/usr/bin/env bash
# https://github.com/p4lang/p4-dpdk-target#running-reference-app
set -e

[ -z "$SDE" ] && echo "Environment variable SDE not set" && exit 1
[ -z "$SDE_INSTALL" ] && echo "Environment variable SDE_INSTALL not set" && exit 1
echo "Using SDE: $SDE"
echo "Using SDE_INSTALL: $SDE_INSTALL"

export LD_LIBRARY_PATH="$SDE_INSTALL/lib:$SDE_INSTALL/lib64:$SDE_INSTALL/lib/x86_64-linux-gnu"
export PYTHONPATH="$SDE_INSTALL/lib/python3.10/:$SDE_INSTALL/lib/python3.10/lib-dynload:$SDE_INSTALL/lib/python3.10/site-packages"
export PYTHONHOME="$SDE_INSTALL/lib/python3.10"

# switch.conf.json looks up config files relative to $SDE_INSTALL,
# so let's copy them over.
CONF_FILES=(pipeline_tdi.json switch_port.json pipeline_ctx.json pipeline.spec)
CONF_DIR="$SDE_INSTALL/share/study-p4/dpdk-pna-tdi"
rm -rf "$CONF_DIR"
mkdir -p "$CONF_DIR"
cp "${CONF_FILES[@]}" "$CONF_DIR"

# Run the command in a log directory to collect all log files there.
mkdir -p switch_log
cd switch_log
"$SDE_INSTALL/bin/bf_switchd" \
    --install-dir "$SDE_INSTALL" \
    --conf-file ../switch_conf.json
