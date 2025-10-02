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

-- Load pckr configuration
require('pckr-config')

-- Load treesitter configuration
require('treesitter-config')

-- Load completion configuration (only if nvim-cmp is installed)
local cmp_ok, _ = pcall(require, 'cmp')
if cmp_ok then
  require('completion-config')
end

-- make sure that Contianerfile syntax highlighting works
require'nvim-treesitter.parsers'.get_parser_configs().dockerfile = {
  install_info = {
    url = "https://github.com/camdencheek/tree-sitter-dockerfile",
    files = {"src/parser.c"}
  },
  filetype = "dockerfile",
}

vim.filetype.add({
  pattern = {
    ['Containerfile'] = 'dockerfile',
  },
})
