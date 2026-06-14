#!/usr/bin/env bash
#
# Restore The Clock settings from the committed group-preferences.plist.
# Run after The Clock is installed (App Store / mas).
#
# Usage: ./restore.sh

set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GROUP_ID="3EYN7PPTPF.com.fabriceleyne.theclock"
SRC="$DIR/group-preferences.plist"
DEST_DIR="$HOME/Library/Group Containers/$GROUP_ID/Library/Preferences"
DEST="$DEST_DIR/$GROUP_ID.plist"

if [ ! -f "$SRC" ]; then
  echo "skip: no committed The Clock group-preferences.plist"
  exit 0
fi

mkdir -p "$DEST_DIR"
if [ -f "$DEST" ]; then
  cp "$DEST" "$DEST.bak.$(date +%Y%m%d-%H%M%S)"
fi

killall "The Clock" >/dev/null 2>&1 || true
cp "$SRC" "$DEST"
open -a "The Clock"

echo "The Clock config restored to $DEST (previous file backed up if present)."
