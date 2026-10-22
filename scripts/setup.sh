#!/usr/bin/env bash
# NOTE: Call with "source setup.sh", not "./setup.sh"

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

ST_TREE="$WORKSPACE_ROOT/openstlinux-6.2"
export MACHINE=stm32mp257f-dk
export DISTRO=tkk-iotcore

# Pull ST/OE source repos with pinned manifest
if [ ! -d "$ST_TREE/.repo" ]; then
    mkdir -p "$ST_TREE"
    (cd "$ST_TREE" && repo init -u "https://github.com/wendeldom/tkk-iotgateway-build.git" -m manifest/pinned-manifest.xml)
fi
(cd "$ST_TREE" && repo sync) || { echo "repo sync failed"; return 1; }

# Copy custom files into st layers (machine, distro, DTs)
"$SCRIPT_DIR/file-sync.sh" || { echo "file-sync script failed"; return 1; }

# Call st envsetup.sh script
cd "$ST_TREE"
set +u
source layers/meta-st/scripts/envsetup.sh
set -u

# Add tkk layers
bitbake-layers add-layer "$WORKSPACE_ROOT/meta-tkk-stm32mp2"
bitbake-layers add-layer "$WORKSPACE_ROOT/meta-tkk-iotcore"