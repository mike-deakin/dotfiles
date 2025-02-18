# My .dotfiles setup

Powered by zsh|tmux|neovim

## TODO/FIXME

 * [all] fix install pathing ___Because___ wezterm install script was incorrectly changing directory for symbolic links made later.
 * [nvim] Add better indent guessing - [indent-o-matic](https://github.com/Darazaki/indent-o-matic) looks reasonable?
 * [nvim] Improve Java support: [nvim-java](https://github.com/nvim-java/nvim-java) seems mostly better than the manual jdtls config
 * [nvim] Write functions to go to/from test files
 * [nvim] Buffer-local keymaps for neotest per filetype.
 * [nvim] Replace `vim-surround` ___Because___ there are some newer alternatives with nicer APIs/key bindings
 * [nvim] Improve completion bindings ___Because___ its much better, but I still make mistakes
 * [nvim] Bring as many bindings into caskey as possible. (LSP, DAP, Treesitter?) ___Because___ bindings without `desc` set don't render well in the keymap finder (\fk)
 * [nvim] Implement or find a lua-friendly version of [repeat.vim](https://github.com/tpope/repeat.vim) ___Because___ using it to make repeatable lua mappings will be useful, especially for syntax-tree-surfer
 * [nvim] Fix DAP setup for debugging.
 * ~~[tmux] Improve the nav pseudo-mode bindings after getting used to using it. ___Because___ it works but doesn't have great ergonomics or many features.~~
 * ~~[tmux] Add a mode indication to the statusline for the nav pseudo-mode ___Because___ there's no feedback about what mode you're currently in.~~
 * ~~[kitty/install] Fix linking of kitty config post-install ___Because___ the kitty installer script automatically creates a config file, which skips my own config linking~~
 * [wezterm] Write install script.
 * [zsh] Use prezto plugin system for app bootstrapping ___Because___ adding completions will be messy without proper grouping of things.
 * [all] Tidy use of .config (XDG_CONFIG)

## Notes

Hack Nerd Font archive download link: https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.0/Hack.zip
