dotfiles
========
I get rather tired of resetting my machine every time I change, and/or inadvertently destroy it.  To that end, this repo is simple personal configurations.  Attribution, where remembered, is given.

It is extraordinarily tempting to script much of the below...but, frankly, there are situations where it is disconcerting.  The flexibility to step through, install by install, ensures that I don't do something horrifically stupid.

This includes the following Vim plugins (ask me some time why they are no longer submodules)
* [NERD Tree](https://github.com/scrooloose/nerdtree)
* [vim-colors-solarized](https://github.com/altercation/vim-colors-solarized)
* [vim-easymotion](https://github.com/Lokaltog/vim-easymotion)
* [vim-markdown](https://github.com/plasticboy/vim-markdown)
* [writer.vim](https://github.com/dsanson/writer.vim)

Setup
-----

Start by installing XCode and ["Command Line Tools"](http://railsapps.github.io/xcode-command-line-tools.html)

### Start at the beginning

There is probably a better logical order than this, but it is what came out of my fingers.

```sh
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"

brew doctor
brew update
brew install git
brew install wget
brew install ack
brew install par

\curl -L https://get.rvm.io | bash -s stable

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

[homebrew-cask](https://github.com/phinze/homebrew-cask) is so much easier

```sh
# install homebrew-cask
brew tap phinze/homebrew-cask
brew install brew-cask

# essentials are just that
brew cask install iterm2
brew cask install nv-alt
brew cask install macvim
brew cask install dropbox
brew cask install virtualbox
brew cask install vagrant
brew cask install divvy
brew cask install vlc
brew cask install firefox
brew cask install google-chrome
brew cask install alfred
brew cask install marked2

# talking is important
brew cask install adium
brew cask install skype
```

### Other applications
Check out those App Store purchases...the history makes life easy.

Some to remember:
* Airmail
* Pocket
* iFlicks
* Tweetbot
* Byword
* Pixelmator

### Chrome Extensions
*link these at some point*

* Google Cast
* LastPass
* Pocket
* Proxy SwtichySharp
* Reddit Enhancement Suite
* Reddit Hover Craft

### Install the Vim Thesaurus

These are simple things that would be silly to embed as a submodule or track in a repository 

```sh
cd ~/.vim
mkd thesaurus
wget http://www.gutenberg.org/dirs/etext02/mthes10.zip
xt mthes10.zip
```
