#!/usr/bin/env bash

HERE=$(readlink -f $(dirname ${BASH_SOURCE:-$0}))
USER_HOME=$(getent passwd ${SUDO_USER:-$USER} | cut -d: -f6)

NVIM_AUTOLOAD_DIR="$USER_HOME/.local/share/nvim/site/autoload"
install_nvim_plugin_manager () {
	git clone --depth 1 "https://github.com/wbthomason/packer.nvim" "$USER_HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
}

install_terminfo () {
	tic $HERE/terminfo
	tic -xe tmux-256color $HERE/tmux/tmux.terminfo
}

if [[ "$OSTYPE" == "darwin"* ]]; then
	source install_functions_mac.sh
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
	source install_functions_linux.sh
else
	echo "Unrecognised OS \"$OSTYPE\"!!"
	exit 1
fi

# Update/initialise submodules (Prezto in particular)
git submodule update --init --recursive

install_zsh
echo "Linking $HERE/zsh/.zshenv to $USER_HOME/.zshenv"
[[ ! -f $USER_HOME/.zshenv ]] && sudo ln -s $HERE/zsh/.zshenv $USER_HOME/.zshenv # points zsh to config in this directory.

install_tmux
echo "Linking $HERE/tmux/.tmux.conf to $USER_HOME/.tmux.conf"
[[ ! -f $USER_HOME/.tmux.conf ]] && sudo ln -s $HERE/tmux/.tmux.conf $USER_HOME/.tmux.conf

install_nvim
echo "Linking $HERE/noevim/.config/nvim to $USER_HOME/.config/nvim"
[[ ! -d $USER_HOME/.config/nvim ]] && sudo ln -s $HERE/neovim/.config/nvim $USER_HOME/.config/nvim

echo "Linking $HERE/git/.gitconfig to $USER_HOME/.gitconfig"
[[ ! -d $USER_HOME/.config/nvim ]] && sudo ln -s $HERE/git/.gitconfig $USER_HOME/.gitconfig \
	&& ln -s $HERE/git/.gitignore $USER_HOME/.gitignore

#install_nvim_plugin_manager
