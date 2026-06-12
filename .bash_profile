##
export PATH=/opt/local/bin:/opt/local/sbin:~/bin:$PATH
export BASH_SILENCE_DEPRECATION_WARNING=1 

# Load the shell dotfiles, and then some:
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{bash_prompt,aliases,functions,extra}; do
  [ -r "$file" ] && source "$file"
done
unset file

# My brain is the small and memberizing things is the hard
export HISTCONTROL=erasedups 
export HISTSIZE=10000
shopt -s histappend

export PATH=/usr/local/bin:$PATH

# Regionalisation Sucks
export LANG=en_US.UTF-8

# Homebrew (works on both Apple Silicon and Intel; safe on a fresh machine)
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Created by `pipx` on 2024-08-13 18:11:50
export PATH="$PATH:$HOME/.local/bin"

command -v thefuck >/dev/null 2>&1 && eval "$(thefuck --alias)"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.bash 2>/dev/null || :

