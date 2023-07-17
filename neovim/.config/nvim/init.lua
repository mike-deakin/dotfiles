-- General
vim.opt.compatible = false
vim.opt.hlsearch = true
vim.opt.lazyredraw = true
vim.opt.number = true
vim.opt.rnu = true
vim.opt.cursorline = true
vim.opt.scrolloff = 20
vim.opt.mouse = ""
vim.opt.fileencodings = vim.opt.fileencodings + { 'utf-8' }
vim.opt.encoding = 'utf-8'
vim.g.maplocalleader = ','

-- Tabs & Whitespace
vim.opt.tabstop = 4 -- column width of tab character
vim.opt.softtabstop = 4 -- treat groups of 4 spaces like a tab char
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 4 -- auto-indent width
vim.cmd([[filetype plugin indent on]]) -- auto-indent based on file type

-- Editor niceties
vim.cmd([[syntax on]])
vim.opt.completeopt = "menu,menuone,noselect"

vim.g.instant_username = 'mdeakin'

require'plugins'
require'theme'
require'keymap'
require'dap-config'
require'telescope-config'
