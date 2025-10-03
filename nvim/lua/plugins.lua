return {
  -- Treesitter for better syntax highlighting and code understanding
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

  -- Telescope and file browser extension
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
    },
    config = function()
      local telescope = require('telescope')
      telescope.setup({
        defaults = {
          prompt_prefix = '   ',
          selection_caret = '❯ ',
        },
        extensions = {
          file_browser = {
            hidden = true,
          },
        },
      })
      -- load file browser extension if available
      pcall(telescope.load_extension, 'file_browser')
    end,
  },

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
}
