# New-Machine Migration

The goal of this repo is to get a brand-new Mac productive with as little manual
work as possible. Most of it is automated by [`install.sh`](install.sh); this
file is the checklist for the parts that can't (or shouldn't) be scripted.

> This is the **runbook** — follow it top to bottom on a new machine. For a
> repo overview, the optional step-by-step manual walkthrough of the automated
> parts, and reference lists of apps and Chrome extensions, see the
> [README](README.md).

## 1. Run the automated setup

```sh
git clone --recurse-submodules https://github.com/tylerhannan/dotfiles.git
cd dotfiles
./install.sh
```

`install.sh` installs the Command Line Tools + Homebrew, symlinks the dotfiles,
runs `brew bundle install` (formulae, casks, and editor extensions), and
restores the app configs under `defaults/` and `karabiner/`.

## 2. Git identity

The repo's `.gitconfig` holds only shared, non-sensitive settings and includes
`~/.gitconfig.local` for identity. Since `~/.gitconfig` is symlinked to the repo,
write your identity to the **local** file (not `--global`, which would follow
the symlink into the repo):

```sh
git config --file ~/.gitconfig.local user.name "Tyler Hannan"
git config --file ~/.gitconfig.local user.email "you@example.com"
```

## 3. Login shell

A fresh macOS defaults to `zsh`, so these bash dotfiles won't load until you
switch:

```sh
chsh -s /bin/bash
```

(Optionally `brew install bash` first for a modern bash, then `chsh -s` to it
after adding it to `/etc/shells`.)

## 4. App Store apps (`mas`)

The Brewfile installs `mas`, but App Store apps must be added after signing in:

```sh
# Sign into the App Store app first, then:
mas list                      # see what's installed (on the OLD machine)
mas install <id>              # install on the new machine
```

App Store-only apps to reinstall: **Things 3, Infuse, Byword** (and Apple's
Keynote/Numbers/Pages if needed). After installing them you can capture them
into the Brewfile with `brew bundle dump --force --file=~/Brewfile`.

## 5. SSH / GPG keys

Keys are **never** committed. Copy them from the old machine (or a backup):

```sh
# from the old machine
rsync -av ~/.ssh/ newmachine:~/.ssh/
chmod 700 ~/.ssh && chmod 600 ~/.ssh/*
```

Re-add keys to the agent / GitHub as needed.

## 6. App settings that sync themselves

- **Cursor / VS Code:** enable Settings Sync (signed-in) — extensions are
  already installed via the Brewfile.
- **Alfred:** Preferences → Advanced → "Set preferences folder…" → point at
  `~/Dropbox`; the new machine picks up workflows, snippets, and themes.
- **Keyboard Maestro:** Preferences → General → "Macro Sync…" → open the synced
  file in `~/Dropbox`.

## 7. Apps installed by hand

- **Adobe Creative Cloud** (Photoshop, Lightroom, InDesign) — personal, not
  work-managed. Install the Creative Cloud desktop app from adobe.com (or
  `brew install --cask adobe-creative-cloud`), then install the individual
  apps from it.
- **Okta Verify**, **Falcon**, **Iru** (formerly Kandji Self Service) — provided
  and managed by work tooling, not this repo. Get them from your MDM / IT portal.

## 8. macOS system defaults (optional)

Review and run the conservative system-preferences script:

```sh
./.macos
```

Log out / restart afterward for everything to take effect.

## 9. Re-snapshotting (keep the repo current)

```sh
brew bundle dump --force --file=~/Brewfile   # packages, casks, extensions
./defaults/export.sh                         # app settings (Rectangle, Ice, …)
cp ~/.config/karabiner/karabiner.json karabiner/karabiner.json
```

Then commit and push.
