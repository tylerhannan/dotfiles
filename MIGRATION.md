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
restores the app configs under `defaults/`, `karabiner/`, and `ghostty/`.

## 2. Git identity

`install.sh` prompts for your name/email and writes them to `~/.gitconfig.local`,
so on a fresh machine this is usually already done. The repo's `.gitconfig` holds
only shared, non-sensitive settings and includes `~/.gitconfig.local` for identity.

To set or change it by hand, write to the **local** file (not `--global`, which
would follow the `~/.gitconfig` symlink into the repo):

```sh
git config --file ~/.gitconfig.local user.name "Tyler Hannan"
git config --file ~/.gitconfig.local user.email "you@example.com"
```

(A `.gitconfig.local.example` template is included if you'd rather copy it.)

## 3. Login shell

A fresh macOS defaults to `zsh`, so these bash dotfiles won't load until you
switch:

```sh
chsh -s /bin/bash
```

(Optionally `brew install bash` first for a modern bash, then `chsh -s` to it
after adding it to `/etc/shells`.)

## 4. App Store apps (`mas`)

Your App Store apps are already listed as `mas` entries in the Brewfile, so they
install automatically — but only once you're signed in. `mas` can't sign you in.

```sh
# 1. Open the App Store app and sign in.
# 2. Then re-run the bundle (install.sh already did this once):
brew bundle install --file=~/Brewfile
```

New App Store apps get captured the next time you run `./sync.sh` (see §9).

## 5. Credentials (GitHub, SSH, GPG)

Keys and tokens are **never** committed. The common case is simple:

**GitHub — just re-authenticate.** Git talks to GitHub over HTTPS via the `gh`
CLI (installed by the Brewfile), with the token cached in the macOS keychain
(`credential.helper = osxkeychain`). The token lives in the keychain, not in a
file, so there is nothing to copy from the old machine:

```sh
gh auth login   # browser/device flow; re-creates the token in the keychain
```

After that, `git` over HTTPS works with no SSH key involved.

**SSH — only the prod bastion key.** The lone key here is for the prod bastion
host (see the `~/.ssh/config` host entry); it's a corp credential, so keep it in
Bitwarden (corp vault) as a secure note. On the new machine, paste it back and
fix permissions:

```sh
mkdir -p ~/.ssh && chmod 700 ~/.ssh
# paste the key into ~/.ssh/prod-bastion-host, then:
chmod 600 ~/.ssh/prod-bastion-host
```

(Or `rsync -av ~/.ssh/ newmachine:~/.ssh/` straight off the old machine, then
`chmod 700 ~/.ssh && chmod 600 ~/.ssh/*`.)

**GPG (only if you sign commits).** Export on the old machine, import on the new:

```sh
gpg --export-secret-keys --armor > secret.asc   # old machine; delete after import
gpg --import secret.asc                          # new machine
```

This repo deliberately stores no secrets and no encrypted blobs — credentials
live in the password manager or come off the old machine.

## 6. App settings

Restored automatically by `install.sh` (committed in this repo):

- **Ghostty:** terminal config (`ghostty/`). The configured font,
  **BerkeleyMono Nerd Font**, is paid and is *not* installed by this repo —
  keep the font file in Dropbox and copy it into `~/Library/Fonts` on the new
  machine (`ghostty/restore.sh` warns if it's missing), or Ghostty falls back.
- **Karabiner-Elements**, **Rectangle**, **Hyperkey**, **Ice**, **The Clock**,
  **SteerMouse** — see `karabiner/` and `defaults/`.

Sync themselves once you sign in / point them at the sync folder:

- **Cursor / VS Code:** enable Settings Sync (signed-in) — extensions are
  already installed via the Brewfile.
- **Alfred:** Preferences → Advanced → "Set preferences folder…" → point at
  `~/Dropbox`; the new machine picks up workflows, snippets, and themes.
- **Keyboard Maestro:** Preferences → General → "Macro Sync…" → open the synced
  file in `~/Dropbox`.

## 7. Org / MDM-managed apps

- **Okta Verify**, **Falcon**, **Iru** (formerly Kandji Self Service) — provided
  and managed by work tooling, not this repo. Install from your MDM / IT portal.

(Adobe Creative Cloud is personal and installs via the Brewfile cask; just sign
in and install the individual apps from the Creative Cloud desktop app.)

## 8. macOS system defaults (optional)

`install.sh` offers to apply these during setup. To review or run them yourself:

```sh
./.macos
```

Log out / restart afterward for everything to take effect.

## 9. Re-snapshotting (keep the repo current)

Run the helper periodically. It flags Homebrew/App Store drift (anything
installed but not yet in the Brewfile) and refreshes the exported app settings
plus the Karabiner and Ghostty configs:

```sh
./sync.sh
```

Then review `git diff`, add anything it flagged to the Brewfile by hand, and
commit. (The Brewfile is edited by hand on purpose, to keep its grouping and
comments — `sync.sh` reports drift rather than overwriting it.)
