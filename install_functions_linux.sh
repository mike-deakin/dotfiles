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
	[[ ! -d /appimage/neovim ]] && mkdir -p /appimage/neovim/
	mkdir __temp && cd __temp

	echo Downloading neovim appimage
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
	chmod u+x nvim.appimage

	echo Installing neovim to /appimage/neovim
	./nvim.appimage --appimage-extract
	mv squashfs-root/* /appimage/neovim/
	ln -s /appimage/neovim/AppRunn /usr/bin/nvim

	cd .. && rm -rf __temp
}

