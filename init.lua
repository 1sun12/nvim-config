-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set termguicolors to enable true color support
vim.opt.termguicolors = true

-- Turn on 'relative' line numbers
vim.opt.relativenumber = true

-- Set up leader key before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Load plugins from the plugins directory
require("lazy").setup("plugins")
