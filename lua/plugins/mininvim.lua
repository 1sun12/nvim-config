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
      
      -- Add smooth animations
      require('mini.animate').setup({
        -- Cursor path
        cursor = {
          enable = true,
          timing = function() return 20 end,
        },
        
        -- Scroll animations
        scroll = {
          enable = true,
          timing = function() return 20 end,
        },
        
        -- Window resize animations
        resize = {
          enable = true,
          timing = function() return 20 end,
        },
        
        -- Window open/close animations
        open = {
          enable = true,
          timing = function() return 20 end,
        },
        close = {
          enable = true,
          timing = function() return 20 end,
        },
      })
    end
  }
}
