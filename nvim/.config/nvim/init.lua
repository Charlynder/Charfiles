vim.wo.number = true

vim.api.nvim_create_user_command('E', 'Explore', {})
vim.api.nvim_create_user_command('Tree', 'Vexplore', {})

vim.keymap.set('n', '<leader>e', ':Explore<CR>')
vim.keymap.set('n', '<leader>v', ':Vexplore<CR>')

require('autoclose').setup()

-- plugins
-- pckr.vim setup
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading plugins so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Load pckr configuration
require('pckr-config')

-- Load treesitter configuration
require('treesitter-config')

-- Load completion configuration (only if nvim-cmp is installed)
local cmp_ok, _ = pcall(require, 'cmp')
if cmp_ok then
  require('completion-config')
end

-- Load telescope configuration (only if telescope is installed)
local telescope_ok, _ = pcall(require, 'telescope')
if telescope_ok then
  require('telescope-config')
end

-- Load harpoon configuration (only if harpoon is installed)
local harpoon_ok, _ = pcall(require, 'harpoon')
if harpoon_ok then
  require('harpoon-config')
end

-- Transparent background across themes
vim.o.termguicolors = true

local transparent_grp = vim.api.nvim_create_augroup('TransparentBG', { clear = true })
vim.api.nvim_create_autocmd({ 'VimEnter', 'ColorScheme' }, {
  group = transparent_grp,
  callback = function()
    local groups = {
      'Normal', 'NormalNC', 'NormalFloat', 'FloatBorder', 'SignColumn',
      'LineNr', 'CursorLineNr', 'Folded', 'NonText', 'EndOfBuffer',
      'MsgArea', 'Pmenu', 'PmenuSel',
      'TelescopeNormal', 'TelescopeBorder', 'WhichKeyFloat', 'NotifyBackground',
    }
    for _, name in ipairs(groups) do
      pcall(vim.api.nvim_set_hl, 0, name, { bg = 'none' })
    end
    -- Slight blending for floating windows and popups (tweak to taste)
    vim.o.winblend = 10
    vim.o.pumblend = 10
  end,
})
