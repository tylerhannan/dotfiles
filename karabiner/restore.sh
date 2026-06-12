#!/usr/bin/env bash
#
# Restore Karabiner-Elements config. Karabiner reads its settings from
# ~/.config/karabiner/karabiner.json, so this just copies the committed
# version into place. Run after Karabiner-Elements is installed.
#
# To re-snapshot the current config back into the repo:
#   cp ~/.config/karabiner/karabiner.json "$(dirname "$0")/karabiner.json"

set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="$HOME/.config/karabiner"

mkdir -p "$DEST"
if [ -f "$DEST/karabiner.json" ]; then
  cp "$DEST/karabiner.json" "$DEST/karabiner.json.bak.$(date +%Y%m%d-%H%M%S)"
fi
cp "$DIR/karabiner.json" "$DEST/karabiner.json"

echo "Karabiner config restored to $DEST/karabiner.json (previous file backed up if present)."
echo "Restart Karabiner-Elements to apply."
