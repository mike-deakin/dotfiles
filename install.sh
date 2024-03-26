#!/usr/bin/env bash

HERE=$(readlink -f $(dirname ${BASH_SOURCE:-$0}))

NVIM_AUTOLOAD_DIR="$USER_HOME/.local/share/nvim/site/autoload"
install_nvim_plugin_manager () {
	git clone --depth 1 "https://github.com/wbthomason/packer.nvim" "$USER_HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
}

install_terminfo () {
	tic $HERE/terminfo
	tic -x $HERE/tmux/tmux.terminfo
}

if [[ "$OSTYPE" == "darwin"* ]]; then
	source install_functions_mac.sh
	install_brew
	USER_HOME=$(dscl . read /users/${SUDO_USER:-$USER} NFSHomeDirectory | cut -d: -f2)
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
	source install_functions_linux.sh
	USER_HOME=$(getent passwd ${SUDO_USER:-$USER} | cut -d: -f6)
else
	echo "Unrecognised OS \"$OSTYPE\"!!"
	exit 1
fi

if [ -z $USER_HOME ]; then
	echo "Unable to determine user home directory. Aborting install."
	exit 2
fi

# Update/initialise submodules (Prezto in particular)
git submodule update --init --recursive

#install_terminal $OSTYPE

install_zsh
echo "Linking $HERE/zsh/.zshenv to $USER_HOME/.zshenv"
[[ ! -f $USER_HOME/.zshenv ]] && ln -s $HERE/zsh/.zshenv $USER_HOME/.zshenv # points zsh to config in this directory.
[[ -d $HERE/zsh/.zprezto ]] && [[ ! -d $HERE/zsh/.zprezto/contrib ]] && ln -s $HERE/zsh/modules $HERE/zsh/.zprezto/contrib

install_tmux
echo "Linking $HERE/tmux/.tmux.conf to $USER_HOME/.tmux.conf"
[[ ! -d $USER_HOME/.config/tmux ]] && ln -s $HERE/tmux $USER_HOME/.config/tmux
[[ ! -d $USER_HOME/.config/tmux-powerline ]] && ln -s $HERE/tmux/powerline $USER_HOME/.config/tmux-powerline

install_nvim
echo "Linking $HERE/noevim/.config/nvim to $USER_HOME/.config/nvim"
[[ ! -d $USER_HOME/.config/nvim ]] && ln -s $HERE/neovim/.config/nvim $USER_HOME/.config/nvim

echo "Linking $HERE/git/.gitconfig to $USER_HOME/.gitconfig"
[[ ! -d $USER_HOME/.config/nvim ]] && ln -s $HERE/git/.gitconfig $USER_HOME/.gitconfig \
	&& ln -s $HERE/git/.gitignore $USER_HOME/.gitignore
