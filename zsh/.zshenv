# .zshenv
# This file is sourced by all instances of Zsh, and thus, it should be kept as
# small as possible and should only define environment variables.

# zsh references $ZDOTFILES to find other dotfiles
# ${(%):-%N} is a magic prompt expansion that resolves this .zshenv file path
THIS=${(%):-%N}
# $THIS could be the real file or the linked file, so resolve it if possible
HERE=${$(readlink $THIS):-$THIS}
export ZDOTDIR=${$(dirname $HERE):-$HOME}

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# XDG environment variables
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_RUNTIME_DIR=$HOME/.runtime

export ZK_NOTEBOOK_DIR=$HOME/slipbox

export NVM_DIR=$HOME/.config/nvm
