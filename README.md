# My .dotfiles setup

Powered by zsh|tmux|neovim

## TODO/FIXME

 * Check `terminfo` install. ___Because___ I haven't tested a fresh install in a while.
 * Change install_nvim function for linux. ___Because___ NeoVim apt package is an old version and does not work with many plugins & scripts.
 * Install a nerdfont. ___Because___ extra symbols/icons are needed for plugins. Currently the install is manual.
 * Fix chicken-and-egg problem of istalling/depending on plugins
 * Add & update alacritty config. ___Because___ cursor is broken on linux in zsh
 * Fix tmux config. ___Because___ `reattach-to-user-namespace` is mac-only and prompt colors are not working on linux
 * Upgrade move-line.lua to be `<cmd>` friendly ___Because___ `<cmd>` is neater and more performant, but does not understand `'<,'>` marks (intentional, see `:help <Cmd>`)
 * Simplify `nvim-dap` config ___Because___ it currently is limited, depends on an extra plugin, and is hard-coded to work with a Parcel application
 * Add akinsho/bufferline.nvim ___Because___ it looks cool.

## Notes

Hack Nerd Font archive download link: https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip
