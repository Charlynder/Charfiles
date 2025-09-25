vim.wo.number = true

vim.api.nvim_create_user_command('E', 'Explore', {})
vim.api.nvim_create_user_command('Tree', 'Vexplore', {})

vim.keymap.set('n', '<leader>e', ':Explore<CR>')
vim.keymap.set('n', '<leader>v', ':Vexplore<CR>')

require("autoclose").setup()
