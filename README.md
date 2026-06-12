dotfiles
========
I get rather tired of rebuilding my machine every time I change it or inadvertently destroy it. To that end, this repo holds a set of simple personal configurations. Attribution, where remembered, is given.

`install.sh` automates the full setup in one command, but every step is also documented manually below so you can step through it one install at a time when you'd rather not run the whole thing blind.

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

The rest of this section documents those same steps manually, for when you'd rather step through them one install at a time.

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

The `Brewfile` is a single manifest of Homebrew formulae, casks (GUI apps), taps, and VS Code / Cursor extensions. Run:

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

**Ghostty** keeps its config in `~/Library/Application Support/com.mitchellh.ghostty/config` (its font, BerkeleyMono Nerd Font, is paid and installed separately):

```sh
./ghostty/restore.sh
```

**Alfred** and **Keyboard Maestro** carry large, binary, and potentially secret-bearing data, so they are *not* committed here — use each app's own sync instead:

- Alfred: Preferences → Advanced → "Set preferences folder…" pointed at Dropbox (`~/Dropbox`), then point the new machine at the same folder.
- Keyboard Maestro: Preferences → General → "Macro Sync…" to a file in `~/Dropbox`, then "Open existing" on the new machine.

### Step 5: macOS system defaults (optional)

`.macos` sets user-domain system preferences. It mirrors this machine (Dark mode, a small auto-hiding Dock, tap-to-click, column-view Finder, analog menu-bar clock, …) plus a few broadly-useful extras (fast key repeat, screenshots to `~/Screenshots`, fewer .DS_Store files, expanded save/print panels). Review it first, then run it:

```sh
./.macos
```

`install.sh` offers to run it as an optional, prompted step. Some changes need a logout/restart to fully take effect.

### Applications

The [`Brewfile`](Brewfile) is the **single source of truth** for installed software — Homebrew formulae, GUI apps (casks, grouped by category), and Mac App Store apps (`mas`). `brew bundle install` (Step 3, or `install.sh`) installs them all, so there's no parallel app list to keep in sync here.

Not covered by the Brewfile, by design:
* **Chrome extensions** — listed below; the Web Store has no CLI installer.
* **Org / MDM-managed apps** (Okta Verify, Falcon, Iru) — installed from your IT portal. See [MIGRATION.md](MIGRATION.md).

`~/Dropbox` backs the `t` todo helper and syncs Alfred / Keyboard Maestro settings.

### Chrome Extensions

* [Google Translate](https://chromewebstore.google.com/detail/aapbdbdomjkkjkaonfhkkikfgjllcleb)
* [Claude](https://chromewebstore.google.com/detail/fcoeoabgfenejglbffodgkkbkcdhcgfn)
* [Google Docs Offline](https://chromewebstore.google.com/detail/ghbmnnjooekpmoecnnnilnnbdlolhkhi)
* [Okta Browser Plugin](https://chromewebstore.google.com/detail/glnpjglilkicbckjpbgcfkogebgllemb)
* [Grammarly](https://chromewebstore.google.com/detail/kbfnbcaeplbcioakkpcpgfkobkghlhen)
* [SVG Export](https://chromewebstore.google.com/detail/naeaaedieihlkmdajjefioajbbdbdjgp)
* [Privacy Badger](https://chromewebstore.google.com/detail/pkehgijcmpdhfbdbbnkijodmdjhbjlgp)

### Install the Vim Thesaurus

A small extra that would be silly to embed as a submodule or track in this repo:

```sh
cd ~/.vim
mkd thesaurus
wget http://www.gutenberg.org/dirs/etext02/mthes10.zip
xt mthes10.zip
```

## Development

A `shellcheck` pre-commit hook lives in `hooks/`. `bootstrap.sh` enables it
automatically (`git config core.hooksPath hooks`), and CI runs the same checks
on every push. To enable it by hand in a clone where you didn't run bootstrap:

```sh
git config core.hooksPath hooks
```

It lints the shell scripts and bash config files before each commit (and is
skipped automatically if `shellcheck` isn't installed). Bypass a single commit
with `git commit --no-verify`.

### Keeping the repo in sync

Run `./sync.sh` periodically to catch drift. It reports Homebrew-managed
packages and App Store apps that are installed but missing from the `Brewfile`
(reporting rather than rewriting, so the curated grouping stays intact), and
refreshes the exported app defaults plus the Karabiner and Ghostty configs.
Review with `git diff` and commit what you want.
