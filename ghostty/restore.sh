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
# Note: the configured font (BerkeleyMono Nerd Font) is a paid font and is not
# installed by this repo — install it separately or Ghostty falls back.

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

# The config asks for BerkeleyMono Nerd Font, which is paid and not shipped
# here. Warn if it isn't installed so the fallback font isn't a surprise.
if ! compgen -G "$HOME/Library/Fonts/*[Bb]erkeley*" >/dev/null \
   && ! compgen -G "/Library/Fonts/*[Bb]erkeley*" >/dev/null; then
  echo "Note: BerkeleyMono Nerd Font not found — install it (e.g. from your Dropbox font backup into ~/Library/Fonts) or Ghostty falls back to a default."
fi
