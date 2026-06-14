#!/usr/bin/env bash
#
# Capture the current desktop/lock wallpaper configuration into this repo.
#
# On macOS 14+ (Sonoma/Sequoia/Tahoe) the wallpaper selection lives in a single
# store file, not in a `defaults` domain:
#   ~/Library/Application Support/com.apple.wallpaper/Store/Index.plist
#
# This machine uses Apple's built-in dynamic wallpapers (provider-based), so the
# Index.plist references no external image files and migrates cleanly on its own.
# If you switch to a custom photo, also copy that image into the repo/Dropbox and
# make sure the new machine has it at the same path — the store records an
# absolute path for custom images.
#
# Usage: ./export.sh   (sync.sh calls this too)

set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$HOME/Library/Application Support/com.apple.wallpaper/Store/Index.plist"

if [ ! -f "$SRC" ]; then
  echo "skip: no wallpaper store at $SRC"
  exit 0
fi

# Normalize to XML so the committed file diffs cleanly.
plutil -convert xml1 -o "$DIR/Index.plist" "$SRC"
echo "exported: wallpaper Index.plist"
