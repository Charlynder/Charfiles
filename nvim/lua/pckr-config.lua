-- pckr.vim configuration
local pckr = require('pckr')

pckr.setup({
  -- Automatically install missing plugins on startup
  autoinstall = true,
  -- Automatically remove unused plugins
  autoremove = true,
})

-- Define your plugins here
pckr.add({
  -- pckr can manage itself
  'lewis6991/pckr.nvim',
  
  -- Treesitter for better syntax highlighting and code understanding
  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate', -- Automatically update parsers after install
  },
  
  -- Oil.nvim - A vim-vinegar like file explorer
  'stevearc/oil.nvim',
  
  -- Completion plugins
  'hrsh7th/nvim-cmp',        -- The completion plugin
  'hrsh7th/cmp-buffer',      -- buffer completions
  'hrsh7th/cmp-path',        -- path completions
  'hrsh7th/cmp-cmdline',     -- cmdline completions
  'hrsh7th/cmp-nvim-lsp',    -- LSP completions
  'hrsh7th/cmp-nvim-lua',    -- Lua completions
  
  -- Snippet engine (required for nvim-cmp)
  'L3MON4D3/LuaSnip',        -- snippet engine
  'saadparwaiz1/cmp_luasnip', -- snippet completions
  
  -- Add your other plugins here
  -- 'nvim-lua/plenary.nvim',
  -- 'nvim-telescope/telescope.nvim',
})
