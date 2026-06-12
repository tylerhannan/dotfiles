dotfiles
========
I get rather tired of resetting my machine every time I change, and/or inadvertently destroy it.  To that end, this repo is simple personal configurations.  Attribution, where remembered, is given.

It is extraordinarily tempting to script much of the below...but, frankly, there are situations where it is disconcerting.  The flexibility to step through, install by install, ensures that I don't do something horrifically stupid.

### Documentation

- **README.md** (this file) — overview of what the repo contains and a detailed, step-by-step setup *reference* (including the optional manual walkthrough, app lists, and Chrome extensions).
- **[MIGRATION.md](MIGRATION.md)** — the condensed *runbook* for setting up a brand-new Mac: run `./install.sh`, then work the checklist of things that can't be scripted. **Start there when migrating to a new machine.**

In short: `install.sh` does the work, `MIGRATION.md` is the checklist that wraps it, and this README is the reference behind both.

This includes the following Vim plugins:
* [NERD Tree](https://github.com/scrooloose/nerdtree)
* [vim-solarized8](https://github.com/lifepillar/vim-solarized8)

Setup
-----

### Quick start (new machine)

One command does the whole automated setup — Command Line Tools, Homebrew, dotfile symlinks, `brew bundle install` (formulae + casks + editor extensions), and app-config restore:

```sh
git clone --recurse-submodules https://github.com/tylerhannan/dotfiles.git
cd dotfiles
./install.sh
```

Then finish the handful of things that can't be scripted (git identity, login shell, App Store apps, SSH keys, settings sync) using the checklist in **[MIGRATION.md](MIGRATION.md)** — that's the authoritative new-machine runbook.

The rest of this section documents the same automated steps manually, for when you'd rather step through them one install at a time (the **Manual steps** below mirror what `install.sh` does; `MIGRATION.md` adds the non-scriptable follow-ups).

### Manual steps

Start by installing Xcode and the Command Line Tools:

```sh
xcode-select --install
```

### Step 1: Install Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Step 2: Clone the dotfiles and bootstrap

`bootstrap.sh` symlinks the dotfiles (including the `Brewfile`) into your home directory, so edits in `$HOME` and this repo stay in sync. Any pre-existing files are moved to `~/.dotfiles-backup/<timestamp>/` first.

```sh
git clone --recurse-submodules https://github.com/tylerhannan/dotfiles.git
cd dotfiles
./bootstrap.sh
```

Set your git identity in the untracked local file (the tracked `.gitconfig` includes it):

```sh
git config --file ~/.gitconfig.local user.name "Your Name Here"
git config --file ~/.gitconfig.local user.email email@domain.com
```

If you cloned without `--recurse-submodules` (so the Vim plugins under `.vim/pack/plugins/start` are empty), pull them in with:

```sh
git submodule update --init --recursive
```

### Step 3: Install everything from the Brewfile

The `Brewfile` is a single manifest of Homebrew formulae, casks (GUI apps), taps, and VSCode/Cursor extensions. Run:

```sh
brew bundle install --file=~/Brewfile
```

To re-snapshot this machine into the Brewfile after installing or removing software (then commit it back to the repo):

```sh
brew bundle dump --force --file=~/Brewfile
```

> Note: the old separate `Caskfile` / `brew cask` workflow is gone — casks now live in the `Brewfile` as `cask "..."` entries.

### Step 4: Restore app configs

After the apps are installed (Step 3), restore their settings from this repo.

**`defaults`-based apps** (Rectangle, Hyperkey, Ice, The Clock, SteerMouse) are captured as plists under `defaults/`. Restore them all at once:

```sh
./defaults/import.sh
```

Re-snapshot the current machine any time with `./defaults/export.sh`, then commit the changed plists. The list of domains lives in `defaults/domains.txt`.

**Karabiner-Elements** keeps its config in `~/.config/karabiner/karabiner.json`:

```sh
./karabiner/restore.sh
```

**Alfred** and **Keyboard Maestro** carry large, binary, and potentially secret-bearing data, so they are *not* committed here — use each app's own sync instead:

- Alfred: Preferences → Advanced → "Set preferences folder…" pointed at Dropbox (`~/Dropbox`), then point the new machine at the same folder.
- Keyboard Maestro: Preferences → General → "Macro Sync…" to a file in `~/Dropbox`, then "Open existing" on the new machine.

### Step 5: macOS system defaults (optional)

`.macos` applies conservative, user-domain system preferences (fast key repeat, Finder path/status bar and file extensions, screenshots to `~/Screenshots`, expanded save/print panels, fewer .DS_Store files, etc.). Review it first, then run it manually:

```sh
./.macos
```

It is intentionally **not** run by `install.sh`. Some changes need a logout/restart to fully take effect.

### Other applications

Most of these now install automatically via the `Brewfile` casks (Step 3). This list is a reference of what's expected on the machine; App Store-only and org/MDM-managed apps (called out in [MIGRATION.md](MIGRATION.md)) still need a manual install.

Some to remember:
* **Editors/Dev:** Cursor, Visual Studio Code, Ghostty, OrbStack
* **Notes/PKM:** Obsidian, Notion, Things3, Byword
* **Window/Input:** Alfred 5, Rectangle, Karabiner-Elements, Keyboard Maestro, Hyperkey, Ice
* **Comms:** Slack, Discord, Telegram, WhatsApp, Zoom
* **Media/Creative:** Adobe CC (Photoshop, Lightroom, InDesign), OBS, Descript, Plex, Infuse
* **Storage/Sync:** Dropbox (also installed via the Brewfile; `~/Dropbox` backs the `t` todo helper)
* **Security:** Bitwarden, LastPass, Tailscale, NordVPN, Okta Verify, Yubico Authenticator

### Chrome Extensions

* [Google Translate](https://chromewebstore.google.com/detail/aapbdbdomjkkjkaonfhkkikfgjllcleb)
* [Claude](https://chromewebstore.google.com/detail/fcoeoabgfenejglbffodgkkbkcdhcgfn)
* [Google Docs Offline](https://chromewebstore.google.com/detail/ghbmnnjooekpmoecnnnilnnbdlolhkhi)
* [Okta Browser Plugin](https://chromewebstore.google.com/detail/glnpjglilkicbckjpbgcfkogebgllemb)
* [LastPass: Free Password Manager](https://chromewebstore.google.com/detail/hdokiejnpimakedhajhdlcegeplioahd)
* [Grammarly](https://chromewebstore.google.com/detail/kbfnbcaeplbcioakkpcpgfkobkghlhen)
* [SVG Export](https://chromewebstore.google.com/detail/naeaaedieihlkmdajjefioajbbdbdjgp)
* [Privacy Badger](https://chromewebstore.google.com/detail/pkehgijcmpdhfbdbbnkijodmdjhbjlgp)

### Install the Vim Thesaurus

These are simple things that would be silly to embed as a submodule or track in a repository 

```sh
cd ~/.vim
mkd thesaurus
wget http://www.gutenberg.org/dirs/etext02/mthes10.zip
xt mthes10.zip
```
