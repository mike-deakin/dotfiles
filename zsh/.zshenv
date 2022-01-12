# .zshenv
# This file is sourced by all instances of Zsh, and thus, it should be kept as
# small as possible and should only define environment variables.

# zsh references $ZDOTFILES to find other dotfiles
# $0 resolves to this file
# :A:h modifies the result to be this absolute directory
# see https://zsh.sourceforge.io/Doc/Release/Expansion.html#Modifiers
export ZDOTDIR=${0:A:h} # TODO: Does not work!

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi
