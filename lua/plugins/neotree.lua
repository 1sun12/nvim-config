return {
	{
	    "nvim-neo-tree/neo-tree.nvim",
	    branch = "v3.x",
	    dependencies = {
	      "nvim-lua/plenary.nvim",
	      "MunifTanjim/nui.nvim",
	      -- "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
	      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	      vim.keymap.set('n', '<leader>n', ':Neotree<CR>')
	    }
	}
}
