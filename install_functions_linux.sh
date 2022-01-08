#!/usr/bin/env bash

install_brew () {
	echo "brew not available on linux, duh!"
}

install_zsh () {
	apt install zsh
}

install_tmux() {
	apt install tmux
}

install_nvim () {
    	echo "*NOT* installing neovim! The version in apt is too old!"
	# apt install neovim
}

