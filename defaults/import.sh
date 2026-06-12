#!/usr/bin/env bash
#
# Restore the macOS `defaults` domains captured in this folder onto a new
# machine. Run this AFTER the corresponding apps are installed
# (i.e. after `brew bundle install`).
#
# Usage: ./import.sh

set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/defaults-$(date +%Y%m%d-%H%M%S)"

while IFS= read -r domain; do
  [[ -z "$domain" || "$domain" == \#* ]] && continue

  plist="$DIR/$domain.plist"
  if [ ! -f "$plist" ]; then
    echo "skip:     $domain (no committed plist)"
    continue
  fi

  # Snapshot the current settings first so the import is reversible.
  mkdir -p "$BACKUP_DIR"
  defaults export "$domain" "$BACKUP_DIR/$domain.plist" 2>/dev/null || true

  defaults import "$domain" "$plist"
  echo "imported: $domain"
done < "$DIR/domains.txt"

echo
echo "Done. Previous settings (if any) were backed up to $BACKUP_DIR"
echo "Quit and relaunch the affected apps (or log out/in) to apply."
