dotfiles
========
I get rather tired of resetting my machine every time I change, and/or inadvertently destroy it.  To that end, this repo is simple personal configurations.  Attribution, where remembered, is given.

It is extraordinarily tempting to script much of the below...but, frankly, there are situations where it is disconcerting.  The flexibility to step through, install by install, ensures that I don't do something horrifically stupid.

This includes the following Vim plugins:
* [NERD Tree](https://github.com/scrooloose/nerdtree)
* [vim-solarized8](https://github.com/lifepillar/vim-solarized8)

Setup
-----

Start by installing Xcode and the Command Line Tools:

```sh
xcode-select --install
```

### Step 1: Install Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Step 2: Clone the dotfiles and bootstrap

`bootstrap.sh` rsyncs the dotfiles (including the `Brewfile`) into your home directory.

```sh
git config --global user.name "Your Name Here"
git config --global user.email email@domain.com
git clone https://github.com/tylerhannan/dotfiles.git
cd dotfiles
source bootstrap.sh
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

### Other applications
Check out those App Store purchases...the history makes life easy.

Some to remember:
* **Editors/Dev:** Cursor, Visual Studio Code, Ghostty, OrbStack
* **Notes/PKM:** Obsidian, Notion, Things3, Byword
* **Window/Input:** Alfred 5, Rectangle, Divvy, Karabiner-Elements, Keyboard Maestro, Hyperkey, Ice
* **Comms:** Slack, Discord, Telegram, WhatsApp, Zoom
* **Media/Creative:** Adobe CC (Photoshop, Lightroom, InDesign), OBS, Descript, Plex, Infuse
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
