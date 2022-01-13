# .zshenv
# This file is sourced by all instances of Zsh, and thus, it should be kept as
# small as possible and should only define environment variables.

# zsh references $ZDOTFILES to find other dotfiles
# ${(%):-%N} is a magic prompt expansion that resolves this .zshenv file path
THIS=${(%):-%N}
# THIS could be the real file or the linked file, so resolve it if possible
HERE=${$(readlink $THIS):-$THIS}
export ZDOTDIR=${$(dirname $HERE):-$HOME}

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi
