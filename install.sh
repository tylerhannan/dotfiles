#!/usr/bin/env bash
#
# install.sh — one-shot new-machine setup.
#
# Run this after cloning the repo:
#   git clone --recurse-submodules https://github.com/tylerhannan/dotfiles.git
#   cd dotfiles
#   ./install.sh
#
# It is idempotent: safe to re-run. See MIGRATION.md for the manual steps
# that cannot be scripted (App Store apps, SSH keys, login shell, etc.).

set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

step() { printf '\n\033[1m==> %s\033[0m\n' "$1"; }

step "Xcode Command Line Tools"
if ! xcode-select -p >/dev/null 2>&1; then
  xcode-select --install
  echo "Re-run ./install.sh once the Command Line Tools finish installing."
  exit 0
fi
echo "present."

step "Homebrew"
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
# Make brew available in this shell (Apple Silicon and Intel paths).
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi
echo "ready: $(brew --version | head -1)"

step "Vim plugin submodules"
git -C "$DIR" submodule update --init --recursive

step "Symlink dotfiles into \$HOME"
"$DIR/bootstrap.sh" --force

step "Install Homebrew bundle (formulae, casks, extensions)"
brew bundle install --file="$HOME/Brewfile"

step "Restore app configs"
"$DIR/defaults/import.sh" || echo "defaults import skipped/partial."
"$DIR/karabiner/restore.sh" || echo "karabiner restore skipped."

step "Done"
cat <<'EOF'
Base setup complete. Finish the manual steps in MIGRATION.md:
  - Sign into the App Store and install App Store-only apps (`mas`)
  - Restore SSH/GPG keys
  - Switch the login shell to bash if desired: chsh -s /bin/bash
  - Enable Cursor/VSCode Settings Sync; point Alfred & Keyboard Maestro at their sync folders
EOF
