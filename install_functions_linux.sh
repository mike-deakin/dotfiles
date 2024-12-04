#!/usr/bin/env bash

install_brew () {
	echo "brew not available on linux, duh!"
}

install_font() {
	curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.0/Hack.zip --output Hack.zip
	unzip Hack.zip -d /usr/local/share/fonts
	cp /usr/local/share/fonts/config/fontconfig /etc/fonts/config.d/
	fc-cache -f -v
	rm Hack.zip
}

install_terminal() {
	HERE=$(readlink -f $(dirname ${BASH_SOURCE:-$0}))
	source $HERE/wezterm/install.sh
}

install_zsh () {
	sudo apt install zsh
}

install_tmux() {
	sudo apt install tmux
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
	ln -s /appimage/neovim/AppRun /usr/bin/nvim

	cd .. && rm -rf __temp
}

