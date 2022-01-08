#!/usr/bin/env bash

HERE=$(readlink -f $(dirname ${BASH_SOURCE:-$0}))
USER_HOME=$(getent passwd ${SUDO_USER:-$USER} | cut -d: -f6)

NVIM_AUTOLOAD_DIR="$USER_HOME/.local/share/nvim/site/autoload"
install_vim-plug () {
    curl -fLo $NVIM_AUTOLOAD_DIR/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

if [[ "$OSTYPE" == "darwin"* ]]; then
	source install_functions_mac.sh
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
	source install_functions_linux.sh
else
	echo "Unrecognised OS \"$OSTYPE\"!!"
	exit 1
fi

echo Installing ZSH
install_zsh
echo "Linking $HERE/.zshenv to $USER_HOME/.zshenv"
[[ ! -f $USER_HOME/.zshenv ]] && ln -s $HERE/.zshenv $USER_HOME/.zshenv # points zsh to config in this directory.

install_tmux
echo "Linking $HERE/.tmux.conf to $USER_HOME/.tmux.conf"
[[ ! -f $USER_HOME/.tmux.conf ]] && ln -s $HERE/.tmux.conf $USER_HOME/.tmux.conf

install_nvim
echo "Linking $HERE/.config/nvim to $USER_HOME/.config/nvim"
[[ ! -d $USER_HOME/.config/nvim ]] && ln -s $HERE/neovim/.config/nvim $USER_HOME/.config/nvim

install_vim-plug
