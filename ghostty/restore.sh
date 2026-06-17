#!/usr/bin/env bash
#
# Restore Ghostty config. On macOS Ghostty reads its config from
# ~/Library/Application Support/com.mitchellh.ghostty/config, so this copies the
# committed version into place. Run after Ghostty is installed.
#
# To re-snapshot the current config back into the repo (sync.sh does this too):
#   cp "$HOME/Library/Application Support/com.mitchellh.ghostty/config" \
#      "$(dirname "$0")/config"
#
# Note: the configured font (Berkeley Mono) is paid and not installed by this repo.

set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="$HOME/Library/Application Support/com.mitchellh.ghostty"

mkdir -p "$DEST"
if [ -f "$DEST/config" ]; then
  cp "$DEST/config" "$DEST/config.bak.$(date +%Y%m%d-%H%M%S)"
fi
cp "$DIR/config" "$DEST/config"

echo "Ghostty config restored to $DEST/config (previous file backed up if present)."
echo "Restart Ghostty or reload the config to apply."

# The config asks for Berkeley Mono (unpatched). Ghostty supplies Nerd icons
# built-in — do not use a self-patched BerkeleyMono Nerd Font (broken metrics).
if ! compgen -G "$HOME/Library/Fonts/BerkeleyMono-*.otf" >/dev/null \
   && ! compgen -G "/Library/Fonts/BerkeleyMono-*.otf" >/dev/null; then
  echo "Note: Berkeley Mono not found in ~/Library/Fonts — install the paid font from usgraphics.com."
fi
