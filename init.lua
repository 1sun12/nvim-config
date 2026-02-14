-- Neovim Configuration
-- Location: ~/.config/nvim/init.lua

-- Basic Settings
vim.opt.number = true           -- Show line numbers
vim.opt.relativenumber = true   -- Show relative line numbers
vim.opt.expandtab = true        -- Use spaces instead of tabs
vim.opt.shiftwidth = 2          -- Size of an indent
vim.opt.tabstop = 4             -- Number of spaces tabs count for
vim.opt.smartindent = true      -- Insert indents automatically
vim.opt.termguicolors = true    -- True color support
vim.opt.mouse = 'a'             -- Enable mouse mode
vim.opt.clipboard = 'unnamedplus' -- Sync with system clipboard

-- Plugin Manager Setup (lazy.nvim)
-- Uncomment below to install lazy.nvim plugin manager
--[[
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin specifications
require("lazy").setup({
  -- Add your plugins here
  -- Example: { "folke/tokyonight.nvim" },
})
--]]

-- Custom keymaps
vim.g.mapleader = ' '           -- Set leader key to space

-- Add your custom configurations below
