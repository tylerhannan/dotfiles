#!/usr/bin/env bash
#
# Export The Clock's real settings (world clocks, menu bar layout, display
# options) from the App Group container. The sparse com.fabriceleyne.theclock
# defaults domain only holds window position noise — not the config you care
# about.
#
# Usage: ./export.sh

set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GROUP_ID="3EYN7PPTPF.com.fabriceleyne.theclock"
SRC="$HOME/Library/Group Containers/$GROUP_ID/Library/Preferences/$GROUP_ID.plist"
DEST="$DIR/group-preferences.plist"

if [ ! -f "$SRC" ]; then
  echo "skip: The Clock group preferences not found at"
  echo "      $SRC"
  echo "      (launch The Clock once, configure it, then re-run)"
  exit 0
fi

cp "$SRC" "$DEST"

python3 - "$DEST" <<'PY'
import plistlib, sys

path = sys.argv[1]
NOISE = {
    "lastLaunchDate",
}
with open(path, "rb") as f:
    data = plistlib.load(f)
for key in list(data):
    if key in NOISE or key.startswith("NSWindow Frame "):
        del data[key]
with open(path, "wb") as f:
    plistlib.dump(data, f, fmt=plistlib.FMT_XML)
PY

echo "exported: $DEST"
