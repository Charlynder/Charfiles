-- load vim options for defaults
require('options')

-- plugins
-- pckr.vim setup
-- make sure to setup `mapleader` and `maplocalleader` before
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

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- load keystroke visualizer
require('keystrokes').setup()
