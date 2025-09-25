-- Harpoon 1 (stable) configuration
local harpoon = require("harpoon")

-- Setup harpoon with basic configuration
harpoon.setup({
    -- Basic configuration to avoid serialization issues
    global_settings = {
        save_on_toggle = false,
        save_on_change = true,
        enter_on_sendcmd = false,
        tmux_autoclose_windows = false,
        excluded_filetypes = { "harpoon" },
        mark_branch = false,
    }
})

-- Key mappings for harpoon 1
vim.keymap.set("n", "<leader>a", function() require("harpoon.mark").add_file() end, { desc = "Harpoon add file" })
vim.keymap.set("n", "<C-e>", function() require("harpoon.ui").toggle_quick_menu() end, { desc = "Harpoon toggle menu" })

-- Navigate to files
vim.keymap.set("n", "<leader>1", function() require("harpoon.ui").nav_file(1) end, { desc = "Harpoon file 1" })
vim.keymap.set("n", "<leader>2", function() require("harpoon.ui").nav_file(2) end, { desc = "Harpoon file 2" })
vim.keymap.set("n", "<leader>3", function() require("harpoon.ui").nav_file(3) end, { desc = "Harpoon file 3" })
vim.keymap.set("n", "<leader>4", function() require("harpoon.ui").nav_file(4) end, { desc = "Harpoon file 4" })

-- Navigate between harpoon files
vim.keymap.set("n", "<leader>hp", function() require("harpoon.ui").nav_prev() end, { desc = "Harpoon previous" })
vim.keymap.set("n", "<leader>hn", function() require("harpoon.ui").nav_next() end, { desc = "Harpoon next" })
