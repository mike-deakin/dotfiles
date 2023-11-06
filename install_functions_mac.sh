#!/usr/bin/env bash

install_brew () {
	echo "Installing Homebrew not implemented!"
#	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

install_font() {
	brew tap homebrew/cask-fonts
	brew install --cask font-hack-nerd-font
}

install_terminal() {
	install_font
	HERE=$(readlink -f $(dirname ${BASH_SOURCE:-$0}))
	source $HERE/wezterm/install.sh
}

install_zsh () {
	brew install zsh
}

install_tmux() {
	brew install tmux
}

install_nvim () {
	brew install neovim
}

