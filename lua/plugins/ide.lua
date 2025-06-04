-- File: lua/plugins/ide.lua
-- Enhanced Neovim IDE configuration

return {
  -- UI and Visual Enhancements --
  
  -- Catppuccin theme - a modern, sleek theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- Load before other plugins
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- Choose from: latte, frappe, macchiato, mocha
        background = { light = "latte", dark = "mocha" },
        transparent_background = false,
        term_colors = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          telescope = true,
          neotree = true,
          which_key = true,
          indent_blankline = { enabled = true },
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
          },
        },
      })
      vim.cmd.colorscheme "catppuccin"
    end,
  },

  -- Neo-tree: File explorer with icon support
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- For file icons
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" },
      { "<leader>o", "<cmd>Neotree focus<cr>", desc = "Focus Explorer" },
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        enable_git_status = true,
        enable_diagnostics = true,
        filesystem = {
          filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = false,
          },
          follow_current_file = true,
          use_libuv_file_watcher = true,
        },
        window = {
          width = 30,
          mappings = {
            ["<space>"] = "none",
          },
        },
        default_component_configs = {
          indent = {
            with_expanders = true,
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },
        },
      })
    end,
  },

  -- Barbecue: VSCode-like winbar showing code context
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("barbecue").setup({
        theme = "catppuccin",
        show_modified = true,
        show_dirname = true,
        show_basename = true,
        show_filename = true,
        context_follow_icon_color = true,
      })
    end,
  },

  -- Bufferline: Enhanced tab/buffer line
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          diagnostics = "nvim_lsp",
          diagnostics_indicator = function(_, _, diag)
            local icons = {
              Error = " ",
              Warn = " ",
              Info = " ",
              Hint = " ",
            }
            local ret = {}
            for severity, icon in pairs(icons) do
              if diag[severity] then
                table.insert(ret, icon)
              end
            end
            return table.concat(ret, " ")
          end,
          offsets = {
            {
              filetype = "neo-tree",
              text = "File Explorer",
              highlight = "Directory",
              separator = true,
            }
          },
          separator_style = "thin",
          always_show_bufferline = true,
        },
      })
    end,
  },

  -- Lualine: Beautiful and customizable statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            "branch",
            { "diff", colored = true },
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              symbols = { error = " ", warn = " ", info = " ", hint = " " },
              colored = true,
            },
          },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        extensions = { "neo-tree", "fugitive" },
      })
    end,
  },

  -- Indent-blankline: Show indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = {
          char = "│",
          tab_char = "│",
        },
        scope = { enabled = true },
        exclude = {
          filetypes = {
            "help",
            "alpha",
            "dashboard",
            "neo-tree",
            "Trouble",
            "lazy",
            "mason",
          },
        },
      })
    end,
  },

  -- Noice: Enhanced UI for messages, cmdline and popupmenu
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
          signature = {
            enabled = true,
            auto_open = {
              enabled = true,
              trigger = true,
              luasnip = true,
              throttle = 50,
            },
          },
          hover = {
            enabled = true,
          },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = true,
        },
        cmdline = {
          enabled = true,
          view = "cmdline_popup",
          format = {
            cmdline = { icon = ">" },
            search_down = { icon = "🔍⌄" },
            search_up = { icon = "🔍⌃" },
            filter = { icon = "$" },
            lua = { icon = "☾" },
            help = { icon = "?" },
          },
        },
        views = {
          cmdline_popup = {
            border = {
              style = "rounded",
              padding = { 0, 1 },
            },
            filter_options = {},
            win_options = {
              winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
            },
          },
        },
      })
    end,
  },

  -- Nvim-notify: Better notifications
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        stages = "fade",
        timeout = 3000,
        background_colour = "#000000",
        icons = {
          ERROR = "",
          WARN = "",
          INFO = "",
          DEBUG = "",
          TRACE = "✎",
        },
      })
      vim.notify = require("notify")
    end,
  },

  -- Modern Features --
  
  -- Web devicons (used by many plugins)
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    config = function()
      require("nvim-web-devicons").setup({
        strict = true,
        override_by_extension = {
          ["astro"] = {
            icon = "",
            color = "#FF7E33",
            name = "Astro",
          },
        },
      })
    end,
  },

  -- Telescope: Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
      { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git Commits" },
      { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git Status" },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          path_display = { "truncate" },
          file_ignore_patterns = { "node_modules", "dist", ".git" },
          layout_config = {
            horizontal = {
              preview_width = 0.55,
              results_width = 0.8,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
        },
      })
    end,
  },
  
  -- LSP Support
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "folke/neodev.nvim", -- Helps with Neovim Lua API
    },
    config = function()
      -- Setup neodev for better Lua development
      require("neodev").setup({})
      
      -- Initialize Mason (LSP installer)
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
      
      -- Initialize mason-lspconfig
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls", -- Lua
          "pyright", -- Python
          "tsserver", -- TypeScript/JavaScript
          "html", -- HTML
          "cssls", -- CSS
          "jsonls", -- JSON
        },
        automatic_installation = true,
      })
      
      -- Configure LSP servers
      local lspconfig = require("lspconfig")
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      
      -- Configure each server
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })
      
      -- Setup other LSP servers with basic config
      local servers = { "pyright", "tsserver", "html", "cssls", "jsonls" }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          capabilities = capabilities,
        })
      end
      
      -- Global LSP mappings
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(event)
          local opts = { buffer = event.buf }
          
          -- LSP keybindings
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)
          vim.keymap.set("n", "<leader>d", "<cmd>Telescope diagnostics<cr>", opts)
          
          -- Diagnostic keymaps
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
          vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
          vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
        end,
      })
      
      -- Configure diagnostics display
      vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
        },
      })
    end,
  },
  
  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- LSP completion
      "hrsh7th/cmp-buffer", -- Buffer completion
      "hrsh7th/cmp-path", -- Path completion
      "hrsh7th/cmp-cmdline", -- Command line completion
      "saadparwaiz1/cmp_luasnip", -- Snippet completion
      "L3MON4D3/LuaSnip", -- Snippet engine
      "rafamadriz/friendly-snippets", -- Useful snippets
      "onsails/lspkind.nvim", -- Icons in completion menu
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")
      
      -- Load friendly snippets
      require("luasnip.loaders.from_vscode").lazy_load()
      
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
            menu = {
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              path = "[Path]",
            },
          }),
        },
      })
      
      -- Set up specific configuration for file types
      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "buffer" },
        }),
      })
      
      -- Set up completion for command line
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },
  
  -- Git integration
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "▎" },
          change = { text = "▎" },
          delete = { text = "▁" },
          topdelete = { text = "▔" },
          changedelete = { text = "▎" },
          untracked = { text = "▎" },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 1000,
          ignore_whitespace = false,
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          
          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end
          
          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })
          
          map("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })
          
          -- Actions
          map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage Hunk" })
          map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset Hunk" })
          map("v", "<leader>hs", function()
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Stage Hunk" })
          map("v", "<leader>hr", function()
            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Reset Hunk" })
          map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage Buffer" })
          map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
          map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset Buffer" })
          map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk" })
          map("n", "<leader>hb", function()
            gs.blame_line({ full = true })
          end, { desc = "Blame Line" })
          map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle Line Blame" })
          map("n", "<leader>hd", gs.diffthis, { desc = "Diff This" })
          map("n", "<leader>hD", function()
            gs.diffthis("~")
          end, { desc = "Diff This ~" })
          map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle Deleted" })
        end,
      })
    end,
  },
  
  -- Quality of Life Improvements --
  
  -- Which Key - Display keybindings
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      local wk = require("which-key")
      wk.setup({
        plugins = {
          marks = true,
          registers = true,
          spelling = {
            enabled = true,
            suggestions = 20,
          },
          presets = {
            operators = true,
            motions = true,
            text_objects = true,
            windows = true,
            nav = true,
            z = true,
            g = true,
          },
        },
        window = {
          border = "rounded",
          padding = { 2, 2, 2, 2 },
        },
        layout = {
          height = { min = 4, max = 25 },
          width = { min = 20, max = 50 },
          spacing = 5,
        },
        hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "^:", "^ ", "^call ", "^lua " },
        triggers_blacklist = {
          i = { "j", "k" },
          v = { "j", "k" },
        },
      })
      
      -- Register key mappings
      wk.register({
        f = {
          name = "Find",
          f = { "Find files" },
          g = { "Live grep" },
          b = { "Buffers" },
          h = { "Help tags" },
          r = { "Recent files" },
        },
        e = { "Toggle Explorer" },
        g = {
          name = "Git",
          c = { "Commits" },
          s = { "Status" },
        },
        h = {
          name = "Hunks",
          s = { "Stage hunk" },
          r = { "Reset hunk" },
          S = { "Stage buffer" },
          u = { "Undo stage" },
          R = { "Reset buffer" },
          p = { "Preview hunk" },
          b = { "Blame line" },
          d = { "Diff this" },
          D = { "Diff this ~" },
        },
        t = {
          name = "Toggle",
          b = { "Toggle blame" },
          d = { "Toggle deleted" },
        },
        d = { "Diagnostics" },
        c = {
          name = "Code",
          a = { "Code action" },
        },
        r = {
          name = "Refactor",
          n = { "Rename" },
        },
      }, { prefix = "<leader>" })
    end,
  },
  
  -- Todo comments - Highlight and search TODO comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "<leader>xt", "<cmd>TodoTelescope<cr>", desc = "Todo Telescope" },
      { "<leader>xT", "<cmd>TodoTrouble<cr>", desc = "Todo Trouble" },
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
    },
    config = function()
      require("todo-comments").setup({
        signs = true,
        keywords = {
          FIX = {
            icon = " ",
            color = "error",
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
          },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
          TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
        highlight = {
          before = "",
          keyword = "wide",
          after = "fg",
          pattern = [[.*<(KEYWORDS)\s*:]],
          comments_only = true,
          max_line_len = 400,
          exclude = {},
        },
        colors = {
          error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
          warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
          info = { "DiagnosticInfo", "#2563EB" },
          hint = { "DiagnosticHint", "#10B981" },
          default = { "Identifier", "#7C3AED" },
          test = { "Identifier", "#FF00FF" },
        },
      })
    end,
  },
}

