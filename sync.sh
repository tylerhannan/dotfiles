#!/usr/bin/env bash
#
# sync.sh — re-snapshot this machine into the repo to fight drift.
#
# It is intentionally NON-destructive to the curated Brewfile: rather than
# running `brew bundle dump` (which would flatten the grouping/comments), it
# reports what drifted so you can update the Brewfile by hand. It does refresh
# the exported app defaults and the Karabiner config, which are meant to be
# regenerated.
#
# Usage: ./sync.sh   (then review `git diff` and commit what you want)

set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BREWFILE="$DIR/Brewfile"

have() { command -v "$1" >/dev/null 2>&1; }

casks_in_brewfile()    { grep '^cask "' "$BREWFILE" | sed -E 's/cask "([^"]+)".*/\1/' | sort; }
formulae_in_brewfile() { grep '^brew "' "$BREWFILE" | sed -E 's/brew "([^"]+)".*/\1/' | sort; }
mas_ids_in_brewfile()  { grep '^mas ' "$BREWFILE" | sed -E 's/.*id: ([0-9]+).*/\1/' | sort; }

# Only the "installed but not captured" direction is reported. The reverse
# (in Brewfile but `brew list` doesn't show it) is noisy here because many apps
# were installed by hand before being added to the Brewfile; `brew bundle`
# installs those as casks on a fresh machine anyway.
if have brew; then
  echo "==> Brew-managed casks missing from the Brewfile"
  comm -23 <(brew list --cask | sort) <(casks_in_brewfile) | sed 's/^/  + /' || true

  echo "==> Formula leaves missing from the Brewfile"
  comm -23 <(brew leaves | sort) <(formulae_in_brewfile) | sed 's/^/  + /' || true
fi

if have mas; then
  echo "==> App Store apps missing from the Brewfile (ids)"
  comm -23 <(mas list | awk '{print $1}' | sort) <(mas_ids_in_brewfile) | sed 's/^/  + /' || true
fi

echo "==> Refreshing exported app defaults"
"$DIR/defaults/export.sh"

if [ -f "$HOME/.config/karabiner/karabiner.json" ]; then
  echo "==> Refreshing Karabiner config"
  cp "$HOME/.config/karabiner/karabiner.json" "$DIR/karabiner/karabiner.json"
fi

GHOSTTY_CONF="$HOME/Library/Application Support/com.mitchellh.ghostty/config"
if [ -f "$GHOSTTY_CONF" ]; then
  echo "==> Refreshing Ghostty config"
  cp "$GHOSTTY_CONF" "$DIR/ghostty/config"
fi

echo
echo "Note: only Homebrew/App Store-managed software is checked. Apps installed"
echo "      by hand (drag-to-Applications, vendor installers) won't show as drift"
echo "      until they're added to the Brewfile."
echo
echo "Done. Review with 'git diff' and update the Brewfile by hand for any drift listed above."
