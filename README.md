dotfiles
========
I get rather tired of resetting my machine every time I change, and/or inadvertently destroy it.  To that end, this repo is simple personal configurations.  Attribution, where remembered, is given.

It is extraordinarily tempting to script much of the below...but, frankly, there are situations where it is disconcerting.  The flexibility to step through, install by install, ensures that I don't do something horrifically stupid.

This includes the following Vim plugins:
* [NERD Tree](https://github.com/scrooloose/nerdtree)
* [vim-solarized8](https://github.com/lifepillar/vim-solarized8)

Setup
-----

Start by installing XCode and ["Command Line Tools"](http://railsapps.github.io/xcode-command-line-tools.html)

### Start at the beginning

There is probably a better logical order than this, but it is what came out of my fingers.

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew bundle --file=~/Brewfile
```

### Time for some dotfiles

```sh
git config --global user.name "Your Name Here"
git config --global user.email email@domain.com
git clone https://github.com/tylerhannan/dotfiles.git
cd dotfiles
source bootstrap.sh
```

### Casks are our friend

GUI apps are installed as casks straight from the `Brewfile` (modern `brew bundle` handles `cask` entries), so the `brew bundle` step above covers them. The legacy `Caskfile` is kept for reference only.

### Other applications
Check out those App Store purchases...the history makes life easy.

Some to remember:
* **Editors/Dev:** Cursor, Visual Studio Code, iTerm, Ghostty, OrbStack
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
