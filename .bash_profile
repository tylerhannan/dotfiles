##
export PATH=/opt/local/bin:/opt/local/sbin:~/bin:$PATH

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

# hub alias
eval "$(hub alias -s)"

# RVM joy, yo.
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
export PATH=/usr/local/bin:$PATH

