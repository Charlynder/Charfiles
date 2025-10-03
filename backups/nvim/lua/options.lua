-- show line numbers
vim.wo.number = true

-- remove statusline
vim.opt.laststatus = 0
vim.opt.showcmd = true

-- change the key for the file explorer
vim.api.nvim_create_user_command('E', 'Explore', {})
vim.api.nvim_create_user_command('Tree', 'Vexplore', {})

vim.keymap.set('n', '<leader>e', ':Explore<CR>')
vim.keymap.set('n', '<leader>v', ':Vexplore<CR>')

-- vim character encoding (utf8)
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- disable backups
vim.opt.backup = false

-- show 10 lines are visable abbove/below when scrolling
vim.scrolloff = 10

-- change tabs to spaces
vim.opt.expandtab = true
vim.opt.smarttab = true
