#!/usr/bin/env bash
#
# Export the macOS `defaults` domains listed in domains.txt into this folder,
# one <bundle-id>.plist per domain, as diff-friendly XML with transient noise
# (Sparkle auto-updater state, window-frame autosave) stripped out.
#
# Usage: ./export.sh

set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

while IFS= read -r domain; do
  [[ -z "$domain" || "$domain" == \#* ]] && continue

  out="$DIR/$domain.plist"
  if ! defaults export "$domain" "$out" 2>/dev/null; then
    echo "skip:     $domain (no such domain on this machine)"
    continue
  fi

  # Strip transient keys and re-emit as XML. plistlib handles arbitrary key
  # names (dots, spaces) that trip up PlistBuddy/plutil keypaths.
  python3 - "$out" <<'PY'
import plistlib, sys

path = sys.argv[1]
NOISE = {
    "SUEnableAutomaticChecks", "SUHasLaunchedBefore", "SULastCheckTime",
    "SUUpdateGroupIdentifier", "SUSkippedVersion", "SUSendProfileInfo",
    "SUAutomaticallyUpdate",
}
with open(path, "rb") as f:
    data = plistlib.load(f)
for key in list(data):
    if key in NOISE or key.startswith("NSWindow Frame "):
        del data[key]
with open(path, "wb") as f:
    plistlib.dump(data, f, fmt=plistlib.FMT_XML)
PY

  echo "exported: $domain"
done < "$DIR/domains.txt"
