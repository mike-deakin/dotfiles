# My .dotfiles setup

Powered by zsh|tmux|neovim

## TODO/FIXME

 * Automate `terminfo` install. ___Because___ italics are not supported by default in MacOS/iTerm2, but are fixed with `terminfo` config.
 * Change install_nvim function. ___Because___ NeoVim apt package is an old version and does not work with many plugins & scripts.
 * Install a nerdfont. ___Because___ extra symbols/icons are needed for plugins. Currently the install is manual.
 * Fix chicken-and-egg problem of istalling/depending on plugins
 * `git submodule init --recursive` in install script. ___Because___ Prezto is installed via a git submodule
 * Add & update alacritty config. ___Because___ cursor is broken on linux in zsh
 * Fix tmux config. ___Because___ `reattach-to-user-namespace` is mac-only and prompt colors are not working on linux

## Notes

Hack Nerd Font archive download link: https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip
