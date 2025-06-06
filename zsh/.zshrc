# Add deno completions to search path
if [[ ":$FPATH:" != *":/Users/deakim01/dotfiles/zsh/completions:"* ]]; then export FPATH="/Users/deakim01/dotfiles/zsh/completions:$FPATH"; fi
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
  export PYENV_ROOT="$HOME/.pyenv"
  [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi
if command -v rbenv > /dev/null; then
  eval "$(rbenv init - zsh)"
fi

export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
export PATH=$PATH:~/.local/bin

autoload -U add-zsh-hook
load-nvmrc() {
  if command -v nvm_find_nvmrc > /dev/null; then
    local nvmrc_path="$(nvm_find_nvmrc)"

    if [[ -n "$nvmrc_path" ]]; then
      local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

      if [[ "$nvmrc_node_version" = "N/A" ]]; then
        nvm install
      elif [[ "$nvmrc_node_version" != "$(nvm version)" ]]; then
        nvm use
      fi
    elif [[ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ]] && [[ "$(nvm version)" != "$(nvm version default)" ]]; then
      nvm use default
    fi
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc >/dev/null

if which jenv > /dev/null; then eval "$(jenv init -)"; fi
if [ -f "$HOME/.cargo/env" ]; then source "$HOME/.cargo/env"; fi
if [ -f "$HOME/.ghcup/env" ]; then source "$HOME/.ghcup/env"; fi
if [ -f "$HOME/work/.zshrc" ]; then source "$HOME/work/.zshrc"; fi
if [ -f "$HOME/play/.zshrc" ]; then source "$HOME/play/.zshrc"; fi
if [ -s "$NVM_DIR/nvm.sh" ]; then source "$NVM_DIR/nvm.sh"; fi  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
if [ -f "$HOME/.local.zshrc" ]; then source "$HOME/.local.zshrc"; fi
if [ -f "$HOME/.deno/env" ]; then source "$HOME/.deno/env"; fi

autoload -U compinit; compinit
