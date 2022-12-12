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
	curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
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

