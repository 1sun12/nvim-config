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
vim.cmd('colorscheme elflord')

-- Built-in completion settings
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.complete = { '.', 'w', 'b', 'u', 'k' }

-- =============================================================================
-- AUTOCOMPLETE TOGGLE
-- Set to 1 to enable VSCode-style auto-completion, 0 to disable completely
-- =============================================================================
local AUTOCOMPLETE_ENABLED = 1

-- Characters that trigger the completion menu (case-insensitive)
-- Add or remove letters here to control what triggers autocomplete
local TRIGGER_CHARS = {
  'a','b','c','d','e','f','g','h','i','j','k','l','m',
  'n','o','p','q','r','s','t','u','v','w','x','y','z',
  '_', '.'
}

-- =============================================================================
-- AUTOCOMPLETE FUNCTIONS (only active when AUTOCOMPLETE_ENABLED = 1)
-- =============================================================================

local function build_trigger_set(chars)
  local set = {}
  for _, c in ipairs(chars) do
    set[c:lower()] = true
    set[c:upper()] = true
  end
  return set
end

local function setup_autocomplete()
  local trigger_set = build_trigger_set(TRIGGER_CHARS)

  vim.opt.completeopt = { 'menu', 'menuone', 'noinsert' }

  -- Auto-open menu when a trigger character is typed
  vim.api.nvim_create_autocmd('TextChangedI', {
    callback = function()
      local col = vim.fn.col('.') - 1
      local line = vim.fn.getline('.')
      local char = line:sub(col, col)

      if col > 0 and trigger_set[char] then
        if vim.fn.pumvisible() == 0 then
          vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes('<C-n>', true, false, true),
            'n',
            false
          )
        end
      end
    end,
  })

  -- Tab: cycle forward through menu (wraps around automatically)
  vim.keymap.set('i', '<Tab>', function()
    return vim.fn.pumvisible() == 1 and '<C-n>' or '<Tab>'
  end, { expr = true })

  -- Shift-Tab: cycle backward through menu
  vim.keymap.set('i', '<S-Tab>', function()
    return vim.fn.pumvisible() == 1 and '<C-p>' or '<S-Tab>'
  end, { expr = true })

  -- Enter: confirm selection
  vim.keymap.set('i', '<CR>', function()
    return vim.fn.pumvisible() == 1 and '<C-y>' or '<CR>'
  end, { expr = true })

  -- Escape: dismiss menu without selecting
  vim.keymap.set('i', '<Esc>', function()
    if vim.fn.pumvisible() == 1 then
      return '<C-e><Esc>'
    end
    return '<Esc>'
  end, { expr = true })
end

-- Only load autocomplete if toggle is on
if AUTOCOMPLETE_ENABLED == 1 then
  setup_autocomplete()
end
