#!/usr/bin/env bash
#
# Restore the macOS `defaults` domains captured in this folder onto a new
# machine. Run this AFTER the corresponding apps are installed
# (i.e. after `brew bundle install`).
#
# Usage: ./import.sh

set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

while IFS= read -r domain; do
  [[ -z "$domain" || "$domain" == \#* ]] && continue

  plist="$DIR/$domain.plist"
  if [ ! -f "$plist" ]; then
    echo "skip:     $domain (no committed plist)"
    continue
  fi

  defaults import "$domain" "$plist"
  echo "imported: $domain"
done < "$DIR/domains.txt"

echo
echo "Done. Quit and relaunch the affected apps (or log out/in) to apply."
