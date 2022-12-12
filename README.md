# My .dotfiles setup

Powered by zsh|tmux|neovim

## TODO/FIXME

 * [nvim] Upgrade move-line.lua to be `<cmd>` friendly ___Because___ `<cmd>` is neater and more performant, but does not understand `'<,'>` marks (intentional, see `:help <Cmd>`)
 * [nvim] Simplify `nvim-dap` config ___Because___ it currently is limited, depends on an extra plugin, and is hard-coded to work with a Parcel application
 * [nvim] Replace `vim-surround` ___Because___ there are some newer alternatives with nicer APIs/key bindings
 * [nvim] Look at vim-snip alternatives ___Because___ lua is cool
 * [nvim] Move `vim-snip` keymaps into snippet config ___Because___ the vimscript binding is clunky and bulky. See: https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#super-tab-like-mapping
 * [nvim] Fix `nvim-ts-autotag` ___Because___ it doesn't appear to be doing anything
 * [nvim] Look at adding [syntax-tree-surfer](https://github.com/ziontee113/syntax-tree-surfer) and/or [tree-climber](https://github.com/drybalka/tree-climber.nvim) ___Because___ They should make navigating and moving code easier
 * [zsh] Create a pseudo-mode for easier pane navigation. [A potentially useful gist.](https://gist.github.com/samoshkin/05e65f7f1c9b55d3fc7690b59d678734) __Because___ pressing <C-b> every time is a bit annoying and I'd like some vim-like movement.

## Notes

Hack Nerd Font archive download link: https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.0/Hack.zip
