-- ~/.config/nvim/lua/plugins/mini.lua
return {
  {
    "echasnovski/mini.nvim",
    version = false,  -- Set to false to use the latest version
    branch = "stable", -- Use the stable branch
    config = function()
      -- You can require and set up specific mini modules here
      -- For example:
      require("mini.pairs").setup({})
      require("mini.comment").setup({})
      require("mini.surround").setup({})
      
      -- Add any other mini modules you want to use
      -- Example for mini.files (file explorer)
      require("mini.files").setup({
        -- Your configuration options here
        mappings = {
          close = 'q',
          go_in = 'l',
          go_out = 'h',
          go_in_plus = '<CR>',
        }
      })

      -- nvim color scheme; your nvim theme!
      require('mini.base16').setup({
	      palette = {
		      -- kimbie dark theme from VsCode
		      base00 = "#221a0f", -- background
		      base01 = "#423523", -- lighter bg
		      base02 = "#51412c", -- selection bg
		      base03 = "#645342", -- comments
		      base04 = "#7c5021", -- dark fg
		      base05 = "#d3af86", -- default fg
		      base06 = "#e3b583", -- light fg
		      base07 = "#fbebd4", -- light bg
		      base08 = "#dc3958", -- variables
		      base09 = "#f79a32", -- ints, bools, cons
		      base0A = "#f06431", -- classes
		      base0B = "#889b4a", -- strings
		      base0C = "#088649", -- reg ex
		      base0D = "#8ab1b0", -- functions
		      base0E = "#98676a", -- keywords
		      base0F = "#b16139", -- deprecated
	      }
      })
      
      -- Example for mini.statusline
      require("mini.statusline").setup({})
    end
  }
}
