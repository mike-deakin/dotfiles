#!/usr/bin/env bash

HERE=$(readlink -f $(dirname ${BASH_SOURCE:-$0}))

link_config() {
	[[ ! -d $XDG_CONFIG_HOME/wezterm ]] && ln -s $HERE $XDG_CONFIG_HOME/wezterm
}

fix_terminfo() {
	tic -x -o ~/.terminfo "$HERE/wezterm.terminfo"
}

install_wezterm() {
	OS=$1
	#TODO: Download and install wezterm per os
	
	echo Not yet implemented, assuming wezterm has been installed
}

install_wezterm $1
fix_terminfo
link_config
