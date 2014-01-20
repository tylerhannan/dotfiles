dotfiles
========
I get rather tired of resetting my machine every time I change, and/or inadvertently destroy it.  To that end, this repo is simple personal configurations.  Attribution, where remembered, is given.

It is extraordinarily tempting to script much of the below...but, frankly, there are situations where it is disconcerting.  The flexibility to step through, install by install, ensures that I don't do something horrifically stupid.

Setup
-----

This assumes you have installed all recent updates and XCode and/or "Command Line Tools"

### Start at the beginning

```sh
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"

brew install git
brew install wget
brew install ack
brew install par
```

### Time for some dotfiles

```sh
git config --global user.name "Your Name Here"
git config --blobal user.email email@domain.com
cd ~
git clone https://github.com/tylerhannan/dotfiles.git
ln -s ~/dotfiles/alias ~/.aliases
ln -s ~/dotfiles/bash_profile ~/.bash_profile
ln -s ~/dotfiles/bash_prompt ~/.bash_prompt
ln -s ~/dotfiles/functions ~/.functions
ln -s ~/dotfiles/vimrc ~/.vimrc
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

### Last Bits of Joy

So it doesn't have to be tracked in this repo, install the thesaurus manually and put it in /users/name/.vim/thesaurus/

```sh
wget http://www.gutenberg.org/dirs/etext02/mthes10.zip
```