# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/dotfiles/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Executes commands at the start of an interactive session.

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

unset EXTENDED_GLOB # is set by "directory" module, but breaks some commands (e.g. git reset HEAD^)

# To customize prompt, run `p10k configure` or edit ~/dotfiles/zsh/.p10k.zsh.
[[ ! -f ~/dotfiles/zsh/.p10k.zsh ]] || source ~/dotfiles/zsh/.p10k.zsh

export PATH="$PATH:/bin"

if [[ "$(uname)" == "Darwin" ]] then
  export EXPAT_DIR="/opt/homebrew/opt/expat"
  export PATH="$EXPAT_DIR/bin:$PATH"

  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if command -v pyenv > /dev/null; then
  eval "$(pyenv init -)"
fi
if command -v rbenv > /dev/null; then
  eval "$(rbenv init - zsh)"
fi

export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

export ZK_NOTEBOOK_DIR=$HOME/commonplace-book

autoload -U add-zsh-hook
load-nvmrc() {
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc >/dev/null

if [ -f "$HOME/work/.zshrc" ]; then source "$HOME/work/.zshrc"; fi
if [ -f "$HOME/play/.zshrc" ]; then source "$HOME/work/.zshrc"; fi
if [ -f "$HOME/.local.zshrc" ]; then source "$HOME/.local.zshrc"; fi
