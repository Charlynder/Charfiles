-- load line numbers as true
vim.wo.number = true

vim.api.nvim_create_user_command('E', 'Explore', {})
vim.api.nvim_create_user_command('Tree', 'Vexplore', {})

vim.keymap.set('n', '<leader>e', ':Explore<CR>')
vim.keymap.set('n', '<leader>v', ':Vexplore<CR>')

-- plugins
-- pckr.vim setup
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading plugins so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- load pckr configuration
require('pckr-config')

-- load treesitter configuration
require('treesitter-config')

-- load completion configuration (only if nvim-cmp is installed)
local cmp_ok, _ = pcall(require, 'cmp')
if cmp_ok then
    require('completion-config')
end

-- load StatusLine to green (#4CC970)
vim.cmd([[
  highlight StatusLine guifg=#4CC970 guibg=#4CC970 ctermfg=white ctermbg=green
  highlight StatusLineNC guifg=#888888 guibg=#3ba05a ctermfg=gray ctermbg=darkgreen
]])
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
