-- Neovim Configuration
-- Location: ~/.config/nvim/init.lua
-- Branch: init/minimal
--
-- ============================================================================
-- CURRENT FEATURES:
-- ============================================================================
-- This configuration is tailored for C development.
--
-- [Editor]
--   - Line numbers (absolute + relative)
--   - Spaces instead of tabs (shiftwidth=2, tabstop=4)
--   - Smart indentation
--   - True color support
--   - Mouse support
--   - System clipboard sync
--   - Space as leader key
--
-- [C Language Support] (via clangd + vim.lsp.config)
--   - Autocompletion for variables, structs, macros, function names
--   - Go-to-definition          (gd)
--   - Hover documentation       (K)
--   - Signature help
--   - Diagnostics (errors/warnings inline)
--   - Code actions               (<leader>ca)
--   - Rename symbol              (<leader>rn)
--   - Format buffer              (<leader>f)
--
-- [Autocompletion] (via nvim-cmp)
--   - LSP-powered completions (from clangd)
--   - Snippet expansion (LuaSnip)
--   - Tab/Shift-Tab to cycle through suggestions
--   - Enter to confirm selection
--
-- [Fuzzy Finder] (via telescope.nvim)
--   - Find files                 (<leader>ff)
--   - Live grep (search text)    (<leader>fg)
--   - Buffers                    (<leader>fb)
--   - Help tags                  (<leader>fh)
--   - NOTE: Install ripgrep and fd for best performance:
--          sudo xbps-install -S ripgrep fd
--
-- [Git Integration] (via gitsigns.nvim)
--   - Added/modified/deleted markers in the sign column
--   - Stage hunk                 (<leader>hs)
--   - Reset hunk                 (<leader>hr)
--   - Preview hunk               (<leader>hp)
--   - Blame current line         (<leader>hb)
--
-- ============================================================================
-- PLUGINS USED:
-- ============================================================================
-- lazy.nvim          - Plugin manager (auto-bootstraps itself)
-- nvim-lspconfig     - LSP client configuration (clangd for C)
-- nvim-cmp           - Autocompletion engine
-- cmp-nvim-lsp       - LSP source for nvim-cmp
-- LuaSnip            - Snippet engine (nvim-cmp dependency)
-- cmp_luasnip        - Snippet source for nvim-cmp
-- telescope.nvim     - Fuzzy finder / search
-- plenary.nvim       - Lua utility library (telescope dependency)
-- gitsigns.nvim      - Git gutter signs and hunk actions
--
-- ============================================================================
-- SYSTEM DEPENDENCIES:
-- ============================================================================
-- clangd             - C language server (sudo xbps-install -S clang-tools-extra21)
-- ripgrep (optional) - Faster telescope grep (sudo xbps-install -S ripgrep)
-- fd (optional)      - Faster telescope file finding (sudo xbps-install -S fd)
-- ============================================================================

-- Basic Settings
vim.opt.number = true             -- Show line numbers
vim.opt.relativenumber = true     -- Show relative line numbers
vim.opt.expandtab = true          -- Use spaces instead of tabs
vim.opt.shiftwidth = 2            -- Size of an indent
vim.opt.tabstop = 4               -- Number of spaces tabs count for
vim.opt.smartindent = true        -- Insert indents automatically
vim.opt.termguicolors = true      -- True color support
vim.opt.mouse = 'a'               -- Enable mouse mode
vim.opt.clipboard = 'unnamedplus' -- Sync with system clipboard
vim.opt.signcolumn = 'yes'        -- Always show sign column (for gitsigns/diagnostics)
vim.opt.updatetime = 250          -- Faster updates (for gitsigns, LSP diagnostics)

-- Leader key
vim.g.mapleader = ' '

-- ============================================================================
-- Plugin Manager (lazy.nvim) - auto-bootstraps on first launch
-- ============================================================================
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

-- ============================================================================
-- Plugin Specifications
-- ============================================================================
require("lazy").setup({

  -- LSP Configuration (C language support via clangd)
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- clangd setup - tailored for C development
      vim.lsp.config('clangd', {
        capabilities = capabilities,
        cmd = { "clangd", "--background-index", "--clang-tidy" },
      })
      vim.lsp.enable('clangd')

      -- LSP keymaps (active when LSP attaches to a buffer)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format({ async = true })
          end, opts)
        end,
      })
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",   -- LSP completion source
      "L3MON4D3/LuaSnip",       -- Snippet engine
      "saadparwaiz1/cmp_luasnip", -- Snippet completion source
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }),
      })
    end,
  },

  -- Telescope (fuzzy finder)
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { '<leader>ff', '<cmd>Telescope find_files<cr>' },
      { '<leader>fg', '<cmd>Telescope live_grep<cr>' },
      { '<leader>fb', '<cmd>Telescope buffers<cr>' },
      { '<leader>fh', '<cmd>Telescope help_tags<cr>' },
    },
  },

  -- Gitsigns (git gutter markers)
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local opts = function(desc)
            return { buffer = bufnr, desc = desc }
          end
          vim.keymap.set('n', '<leader>hs', gs.stage_hunk, opts('Stage hunk'))
          vim.keymap.set('n', '<leader>hr', gs.reset_hunk, opts('Reset hunk'))
          vim.keymap.set('n', '<leader>hp', gs.preview_hunk, opts('Preview hunk'))
          vim.keymap.set('n', '<leader>hb', function()
            gs.blame_line({ full = true })
          end, opts('Blame line'))
        end,
      })
    end,
  },

})
