# Taken from https://github.com/cpitt/zsh-dotenv

source_env() {
  if [[ -f .env ]]; then
    if [[ -o a ]]; then
      source .env
    else
      set -a
      source .env
      set +a
    fi
  fi
}

add-zsh-hook chpwd source_env
