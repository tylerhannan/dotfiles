# Brewfile — Homebrew manifest for new-machine migration.
#
# Restore everything on a new machine:
#   brew bundle install --file=~/Brewfile
#
# Re-snapshot this machine after installing/removing things:
#   brew bundle dump --force --file=~/Brewfile
#
# Check what is missing without installing:
#   brew bundle check --file=~/Brewfile
#
# Covers Homebrew formulae, casks, taps, Mac App Store apps (mas), and
# VSCode/Cursor extensions. `mas` entries require being signed into the
# App Store before `brew bundle install`.

tap "nikitabobko/tap"

# Mac App Store command-line interface (lets `brew bundle dump` capture App Store apps as `mas` entries)
brew "mas"
# Search tool like grep, but optimized for programmers
brew "ack"
# Asciicast to GIF converter
brew "agg"
# Record and share terminal sessions
brew "asciinema"
# Zstandard is a real-time compression algorithm
brew "zstd"
# GNU binary tools for native development
brew "binutils"
# GNU internationalization (i18n) and localization (l10n) library
brew "gettext"
# Object-file caching compiler wrapper
brew "ccache"
# Cross-platform make
brew "cmake"
# Pack, ship and run any application as a lightweight container
brew "docker"
# Embeddable SQL OLAP Database Management System
brew "duckdb"
# Play, record, convert, and stream select audio and video codecs
brew "ffmpeg"
# Collection of GNU find, xargs, and locate
brew "findutils"
# GNU compiler collection
brew "gcc"
# GitHub command-line tool
brew "gh"
# Distributed revision control system
brew "git"
# GNU grep, egrep and fgrep
brew "grep"
# World's fastest and most advanced password recovery utility
brew "hashcat"
# C/C++ and Java libraries for Unicode and globalization
brew "icu4c@76"
# CLI for the Jinja2 templating language
brew "jinja2-cli"
# Lightweight and flexible command-line JSON processor
brew "jq"
# Open-source, cross-platform JavaScript runtime environment
brew "node"
# Interactive environments for writing and running code
brew "jupyterlab"
# Generic library support script
brew "libtool"
# Next-gen compiler infrastructure
brew "llvm"
# GUI for vim, made for macOS
brew "macvim"
# Netwide Assembler (NASM) is an 80x86 assembler
brew "nasm"
# Small build system for use with gyp or CMake
brew "ninja"
# Paragraph reflow for email
brew "par"
# Execute binaries from Python packages in isolated environments
brew "pipx"
# Python library for creating static, animated, and interactive visualizations
brew "python-matplotlib"
# Interpreted, interactive, object-oriented programming language
brew "python@3.11"
# Interpreted, interactive, object-oriented programming language
brew "python@3.12"
# Interpreted, interactive, object-oriented programming language
brew "python@3.13"
# Static analysis tool for shell scripts
brew "shellcheck"
# Terminal multiplexer with VT100/ANSI terminal emulation
brew "screen"
# Programmatically correct mistyped console commands
brew "thefuck"
# Pager/text based browser
brew "w3m"
# Internet file retriever
brew "wget"
# Feature-rich command-line audio/video downloader
brew "yt-dlp"

# --- GUI applications --------------------------------------------------------
# `brew bundle dump --force` will re-sort these and add description comments.
# App Store-only apps (Things 3, Infuse, Byword, ...) and org/MDM-managed apps
# (Okta Verify, Falcon, Iru) are intentionally not listed here. See MIGRATION.md.

# Editors & dev
cask "cursor"
cask "visual-studio-code"
cask "ghostty"
cask "orbstack"

# Productivity & notes
cask "obsidian"
cask "notion"
cask "clickup"
cask "claude"

# Window & input management
cask "rectangle"
cask "alfred"
cask "keyboard-maestro"
cask "karabiner-elements"
cask "hyperkey"
cask "jordanbaird-ice"
cask "steermouse"

# Browsers
cask "google-chrome"
cask "firefox"

# Comms & meetings
cask "discord"
cask "slack"
cask "telegram"
cask "whatsapp"
cask "zoom"
cask "gotomeeting"

# Media
cask "vlc"
cask "descript"
cask "plex"
cask "obs"

# Creative (installs the Creative Cloud desktop app; pick individual apps from it)
cask "adobe-creative-cloud"

# Security & network
cask "bitwarden"
cask "tailscale"
cask "nordvpn"
cask "yubico-authenticator"

# Storage, sync & utilities
cask "dropbox"
cask "appcleaner"
cask "sonos"
cask "garmin-express"

# Misc / research / firmware
cask "mendeley"
cask "qmk-toolbox"

# --- Mac App Store apps (sign into the App Store first) ----------------------
mas "Byword", id: 420212497
mas "Deliveries", id: 290986013
mas "Infuse", id: 1136220934
mas "Keynote", id: 409183694
mas "Numbers", id: 409203825
mas "reMarkable", id: 1276493162
mas "Screen Mirror to TV & Device", id: 1496988766
mas "The Clock", id: 488764545
mas "Things", id: 904280696

vscode "anthropic.claude-code"
vscode "ecmel.vscode-html-css"
vscode "ms-python.debugpy"
vscode "ms-python.python"
vscode "ms-python.vscode-pylance"
vscode "ms-python.vscode-python-envs"
vscode "ms-vscode.vscode-chat-customizations-evaluations"
vscode "ms-vscode.wordcount"
vscode "shd101wyy.markdown-preview-enhanced"
vscode "streetsidesoftware.code-spell-checker"
vscode "yzhang.markdown-all-in-one"
