#!/usr/bin/env bash
#
# bootstrap.sh — link the dotfiles in this repo into $HOME.
#
# Originally based on https://github.com/mathiasbynens/dotfiles (rsync copy),
# reworked to use symlinks so edits in $HOME and the repo never drift apart.
#
# Usage:
#   ./bootstrap.sh        # prompts before touching $HOME
#   ./bootstrap.sh -f     # skip the prompt

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

# Files/directories in the repo to symlink into $HOME.
LINKS=(
  .aliases
  .bash_profile
  .bash_prompt
  .functions
  .gitconfig
  .vimrc
  .vim
  Brewfile
)

link_one() {
  local name="$1"
  local src="$DOTFILES_DIR/$name"
  local dest="$HOME/$name"

  if [ ! -e "$src" ]; then
    echo "skip:   $name (not in repo)"
    return
  fi

  # Already linked correctly? Nothing to do.
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    echo "ok:     $name"
    return
  fi

  # Back up anything real that is in the way.
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    mkdir -p "$BACKUP_DIR"
    mv "$dest" "$BACKUP_DIR/"
    echo "backup: $name -> $BACKUP_DIR/"
  fi

  ln -s "$src" "$dest"
  echo "link:   $name -> $src"
}

doIt() {
  echo "Linking dotfiles from $DOTFILES_DIR into $HOME"

  # Make sure the Vim plugin submodules are populated.
  git -C "$DOTFILES_DIR" submodule update --init --recursive

  # Enable the repo's shellcheck pre-commit hook for this clone.
  git -C "$DOTFILES_DIR" config core.hooksPath hooks

  for name in "${LINKS[@]}"; do
    link_one "$name"
  done

  # shellcheck disable=SC1090
  source "$HOME/.bash_profile"
  echo "Done. Any pre-existing files were moved to $BACKUP_DIR"
}

if [ "${1:-}" = "--force" ] || [ "${1:-}" = "-f" ]; then
  doIt
else
  read -r -p "This will symlink dotfiles into your home directory (existing files are backed up). Continue? (y/n) " -n 1 REPLY
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt
  fi
fi
