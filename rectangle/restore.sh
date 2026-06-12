#!/usr/bin/env bash
#
# Restore Rectangle (window manager) settings from the committed config.
# Run this AFTER Rectangle is installed (i.e. after `brew bundle install`).
#
# To re-snapshot the current settings back into the repo:
#   defaults export com.knollsoft.Rectangle \
#     "$(dirname "$0")/com.knollsoft.Rectangle.plist"

set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

defaults import com.knollsoft.Rectangle "$DIR/com.knollsoft.Rectangle.plist"
killall Rectangle 2>/dev/null || true

echo "Rectangle config imported. Relaunch Rectangle to apply."
