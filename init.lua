-- Basic Settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250

-- Leader key
vim.g.mapleader = ' '

-- Syntax highlighting (on by default, but explicit)
vim.cmd('syntax on')
vim.cmd('filetype plugin indent on')

-- Colorscheme (try: habamax, retrobox, slate, desert, industry)
-- Type `:colorscheme ` and press Tab to cycle through all schemes
-- I recommend `habamax`, `murphy`, `desert`, `evening`, `slate`, or `elflord`
vim.cmd('colorscheme elflord')

-- Built-in completion settings
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.complete = { '.', 'w', 'b', 'u', 'k'}
