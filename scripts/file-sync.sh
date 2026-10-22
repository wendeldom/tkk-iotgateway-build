#!/usr/bin/env bash
set -euo pipefail

# get absoulte paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

BSP_LAYER="$WORKSPACE_ROOT/meta-tkk-stm32mp2"
DISTRO_LAYER="$WORKSPACE_ROOT/meta-tkk-iotcore"
ST_TREE="$WORKSPACE_ROOT/openstlinux-6.2"

MACHINE_CONF_DST="$ST_TREE/layers/meta-st/meta-st-stm32mp-addons/conf/machine/"
DISTRO_CONF_DST="$ST_TREE/layers/meta-st/meta-st-openstlinux/conf/distro/"
MX_DST="$ST_TREE/layers/meta-st/meta-st-stm32mp-addons"

echo "==> Copying machine.conf"
cp "$BSP_LAYER/conf/machine/stm32mp257f-dk.conf" "$MACHINE_CONF_DST"

echo "==> Copying distro.conf"
cp "$DISTRO_LAYER/conf/distro/tkk-iotcore.conf" "$DISTRO_CONF_DST"

echo "==> Copying CubeMX device trees"
cp -r "$BSP_LAYER/mx" "$MX_DST"

echo "File copy finished"