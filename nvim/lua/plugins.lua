return {
    -- Nvim Surround
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end
    },

    {
        "christoomey/vim-tmux-navigator",
        lazy = false
    },
    
    -- Harpoon2
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
           require('harpoon-config')
        end
    },

    -- Rosé Pine
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        priority = 1000,
        config = function()
            require('rose-pine').setup({
                variant = 'main', -- 'main', 'moon', or 'dawn'
                disable_background = true,
                disable_float_background = true,
                disable_italics = false,
            })
            vim.cmd('colorscheme rose-pine')
        end
    },

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require('treesitter-config')
        end,
    },

    -- Refactoring
    {
        'ThePrimeagen/refactoring.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim', -- refactoring.nvim requires plenary.nvim
            'nvim-treesitter/nvim-treesitter',
        },
        config = function()
            local refactoring = require('refactoring')
            local function refactor(name)
                return function()
                    refactoring.refactor(name)
                end
            end

            -- Select refactor operation with vim.ui.select (or Telescope if configured)
            vim.keymap.set({ "n", "x" }, "<leader>R", refactoring.select_refactor, { desc = "Select Refactor" })

            -- Example specific refactor operations:
            vim.keymap.set({ "x" }, "<leader>Rc", function()
                return refactoring.refactor('Extract Function')
            end, { expr = true, desc = "Extract Function" })

            vim.keymap.set({ "x" }, "<leader>Rv", function()
                return refactoring.refactor('Extract Variable')
            end, { expr = true, desc = "Extract Variable" })

            vim.keymap.set({ "n", "x" }, "<leader>Ri", function()
                return refactoring.refactor('Inline Variable')
            end, { expr = true, desc = "Inline Variable" })

            -- debugger functionality
            vim.keymap.set({ "n", "x" }, "<leader>Rp", refactor('Printf'), { desc = "Insert Printf" })
            vim.keymap.set({ "n", "x" }, "<leader>RP", refactor('Print Var'), { desc = "Insert Print Var" })
            vim.keymap.set({ "n" }, "<leader>Rc", refactor('Cleanup'), { desc = "Cleanup Debug" })
        end
    },

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
                    prompt_prefix = ' 🔎  ',
                    selection_caret = '❯',
                },
                extensions = {
                    file_browser = {
                        hidden = true,
                        hijack_netrw = true, -- Telescope instead of netrw
                    },
                },
            })
            -- load file browser extension
            pcall(telescope.load_extension, 'file_browser')
        end,
    },

    -- Which-key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "modern",
        },
        config = function()
            local wk = require("which-key")
            wk.setup({
                preset = "modern",
            })

            -- Add key descriptions
            wk.add({
                { "<leader>r", group = "refactor" },
                { "<leader>w", desc = "Save file" },
                { "<leader>q", desc = "Save and quit" },
                { "<leader>Q", desc = "Quit without saving" },
                { "<leader>e", desc = "File explorer" },
                { "<leader>v", desc = "File explorer" },
            })
        end,
    },

    -- Completion plugins
    'hrsh7th/nvim-cmp',     -- The completion plugin
    'hrsh7th/cmp-buffer',   -- buffer completions
    'hrsh7th/cmp-path',     -- path completions
    'hrsh7th/cmp-cmdline',  -- cmdline completions
    'hrsh7th/cmp-nvim-lsp', -- LSP completions
    'hrsh7th/cmp-nvim-lua', -- Lua completions

    -- Snippet engine (required for nvim-cmp)
    'L3MON4D3/LuaSnip',         -- snippet engine
    'saadparwaiz1/cmp_luasnip', -- snippet completions
}
