#!/usr/bin/env bash
#
# Restore the desktop/lock wallpaper configuration captured by export.sh.
#
# Copies the committed Index.plist into the macOS wallpaper store and reloads
# WallpaperAgent so the change takes effect without a logout. The committed
# config uses Apple's built-in dynamic wallpapers, so no image files are needed.
#
# Usage: ./restore.sh   (install.sh calls this too)

set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$DIR/Index.plist"
DEST_DIR="$HOME/Library/Application Support/com.apple.wallpaper/Store"
DEST="$DEST_DIR/Index.plist"

if [ ! -f "$SRC" ]; then
  echo "skip: no committed wallpaper Index.plist"
  exit 0
fi

mkdir -p "$DEST_DIR"
if [ -f "$DEST" ]; then
  cp "$DEST" "$DEST.bak.$(date +%Y%m%d-%H%M%S)"
fi
cp "$SRC" "$DEST"

# Reload the wallpaper agent so the new selection is picked up immediately.
killall WallpaperAgent >/dev/null 2>&1 || true

echo "Wallpaper restored (previous Index.plist backed up if present)."
echo "If it doesn't update immediately, log out/in to apply."
