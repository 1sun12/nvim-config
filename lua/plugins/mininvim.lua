-- ~/.config/nvim/lua/plugins/mini.lua
return {
  {
    "echasnovski/mini.nvim",
    version = false,  -- Set to false to use the latest version
    branch = "stable", -- Use the stable branch
    config = function()
      -- Basic mini modules setup
      require("mini.pairs").setup({})
      require("mini.comment").setup({})
      require("mini.surround").setup({})
      
      -- Mini files setup
      require("mini.files").setup({
        mappings = {
          close = 'q',
          go_in = 'l',
          go_out = 'h',
          go_in_plus = '<CR>',
        }
      })

      -- Setup indent scope with animation
      require('mini.indentscope').setup({
        symbol = '│',
        options = { try_as_border = true },
        draw = {
          animation = function(_, _) return 20 end -- Smooth animation timing
        }
      })

      -- Setup minimap
      require('mini.map').setup({
        integrations = {
          require('mini.map').gen_integration.builtin_search(),
          require('mini.map').gen_integration.diagnostic(),
        },
        window = {
          show_integration_count = false,
        },
      })

      -- Setup mini.completion
      require('mini.completion').setup({
        -- Delay (in ms) between text modification and completion popup show
        delay = { completion = 100 },
        
        -- Configuration for popup window
        window = {
          info = { height = 25, width = 80, border = 'single' },
          signature = { height = 25, width = 80, border = 'single' },
        },

        -- Sources for completion. Default: all LSP + buffer
        lsp_completion = {
          source_func = 'omnifunc',
          auto_setup = true,
          process_items = function(items, base)
            -- Show up to 10 completion items
            return vim.list_slice(items, 1, 10)
          end
        },

        -- Additional sources for completion
        fallback_sources = {
          { name = 'path' },        -- File system paths
          { name = 'ctags' },       -- Tags from ctags
          { name = 'buffer' },      -- Current buffer words
        },

        -- Characters that trigger completion
        mappings = {
          force_twostep = '<C-Space>',  -- Force two-step completion
          force_fallback = '<A-Space>',  -- Force fallback completion
        }
      })

      -- nvim color scheme; your nvim theme!
      require('mini.base16').setup({
        palette = {
          -- VSCode Abyss theme
          base00 = "#000c18", -- Background
          base01 = "#0a1721", -- Lighter background
          base02 = "#122231", -- Selection background
          base03 = "#1c3448", -- Comments, invisibles
          base04 = "#384f66", -- Dark foreground
          base05 = "#7c99b6", -- Default foreground
          base06 = "#a9bcd1", -- Light foreground
          base07 = "#d7e3ed", -- Light background
          base08 = "#f07178", -- Variables, XML tags
          base09 = "#f78c6c", -- Integers, Boolean, Constants
          base0A = "#ffcb6b", -- Classes, Markup Bold
          base0B = "#c3e88d", -- Strings
          base0C = "#89ddff", -- Support, Regular Expressions
          base0D = "#82aaff", -- Functions, Methods
          base0E = "#c792ea", -- Keywords, Storage
          base0F = "#ff5370", -- Deprecated, Opening/Closing Embedded Language Tags
        }
      })
      
      -- Example for mini.statusline
      require("mini.statusline").setup({})
    end
  }
}
