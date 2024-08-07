local plugins = {
    -- theme
    {
        "catppuccin/nvim",
        cond = not vim.g.vscode,
        config = function()
            require("daneharnett.catppuccin").init()
        end,
        lazy = false,
        name = "catppuccin",
        -- colorschemes need high priority
        priority = 1000,
    },
    -- enhanced vim.notify ui
    { "rcarriga/nvim-notify" },
    -- treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("daneharnett.treesitter").init()
        end,
    },
    {
        "nvim-treesitter/completion-treesitter",
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
    },
    {
        "nvim-treesitter/playground",
    },
    -- nvim-biscuits
    {
        "code-biscuits/nvim-biscuits",
        cond = not vim.g.vscode,
        config = function()
            require("daneharnett.biscuits").init()
        end,
    },
    -- A collection of language packs for Vim.
    {
        "sheerun/vim-polyglot",
    },
    -- buffer line (top of buffer)
    {
        "akinsho/bufferline.nvim",
        config = function()
            require("daneharnett.bufferline").init()
        end,
        dependencies = {
            {
                "nvim-tree/nvim-web-devicons",
            },
        },
    },
    -- status line (bottom of buffer)
    {
        "nvim-lualine/lualine.nvim",
        cond = not vim.g.vscode,
        config = function()
            require("daneharnett.lualine").init()
        end,
        dependencies = {
            {
                "nvim-tree/nvim-web-devicons",
            },
        },
    },
    -- lsp
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("daneharnett.lsp").init()
        end,
        dependencies = {
            {
                "williamboman/mason.nvim",
            },
            {
                "williamboman/mason-lspconfig.nvim",
            },
            { "WhoIsSethDaniel/mason-tool-installer.nvim" },
            {
                "hrsh7th/cmp-nvim-lsp",
            },
            {
                "j-hui/fidget.nvim",
                tag = "legacy",
            },
            {
                "b0o/schemastore.nvim",
            },
        },
    },
    {
        "stevearc/conform.nvim",
        config = function()
            require("daneharnett.formatting").init()
        end,
        event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
    },
    {
        "mfussenegger/nvim-lint",
        config = function()
            require("daneharnett.linting").init()
        end,
        event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
    },
    -- Disabling via commenting this for now as it doesn't quite meet my needs,
    -- more tinkering required.
    -- {
    --     "creativenull/diagnosticls-configs-nvim",
    --     dependencies = {
    --         {
    --             "neovim/nvim-lspconfig",
    --         },
    --     },
    --     config = function()
    --         require("daneharnett.diagnosticls").init()
    --     end,
    -- },
    -- {
    --     "creativenull/efmls-configs-nvim",
    --     dependencies = {
    --         {
    --             "neovim/nvim-lspconfig",
    --         },
    --     },
    --     config = function()
    --         require("daneharnett.efmls").init()
    --     end,
    -- },
    {
        "nvimdev/lspsaga.nvim",
        config = function()
            require("daneharnett.lspsaga").init()
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        event = "LspAttach",
    },
    -- completion
    {
        "hrsh7th/nvim-cmp",
        config = function()
            require("daneharnett.completion").init()
        end,
        dependencies = {
            {
                "hrsh7th/cmp-nvim-lsp",
            },
            {
                "hrsh7th/cmp-buffer",
            },
            {
                "onsails/lspkind-nvim",
            },
            {
                "L3MON4D3/LuaSnip",
            },
            {
                "saadparwaiz1/cmp_luasnip",
            },
        },
        event = "InsertEnter",
    },
    -- file-tree sidebar explorer
    {
        "nvim-tree/nvim-tree.lua",
        config = function()
            require("daneharnett.nvim-tree").init()
        end,
    },
    -- harpoon
    {
        "ThePrimeagen/harpoon",
        dependencies = {
            {
                "nvim-lua/plenary.nvim",
            },
        },
    },
    -- telescope
    {
        "nvim-telescope/telescope.nvim",
        config = function()
            require("daneharnett.telescope").init()
        end,
        dependencies = {
            {
                "nvim-lua/popup.nvim",
            },
            {
                "nvim-lua/plenary.nvim",
            },
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
            { "nvim-telescope/telescope-ui-select.nvim" },
        },
        event = "VeryLazy",
    },
    -- trouble
    {
        "folke/trouble.nvim",
        config = function()
            require("daneharnett.trouble").init()
        end,
        dependencies = {
            {
                "nvim-tree/nvim-web-devicons",
            },
        },
    },
    -- editorconfig
    {
        "editorconfig/editorconfig-vim",
    },
    -- vim-smoothie for smooth scrolling
    {
        "psliwka/vim-smoothie",
    },
    -- comments
    {
        "numToStr/Comment.nvim",
        config = function()
            require("daneharnett.comment").init()
        end,
    },
    -- autopairs
    {
        "windwp/nvim-autopairs",
        config = function()
            require("daneharnett.autopairs").init()
        end,
    },
    -- terminal
    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("daneharnett.toggleterm").init()
        end,
    },
    -- run tests
    {
        "vim-test/vim-test",
        config = function()
            require("daneharnett.tests").init()
        end,
    },
    -- show colors visually
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("daneharnett.colorizer").init()
        end,
    },
    -- git
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("daneharnett.gitsigns").init()
        end,
    },
    {
        "tpope/vim-fugitive",
    },
    {
        "APZelos/blamer.nvim",
        config = function()
            require("daneharnett.blamer").init()
        end,
    },
    {
        "nvim-pack/nvim-spectre",
        config = function()
            require("daneharnett.spectre").init()
        end,
        dependencies = {
            {
                "nvim-tree/nvim-web-devicons",
                "nvim-lua/plenary.nvim",
            },
        },
    },
    -- NOTE: this plugin highlights these types of comments.
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
    {
        "OlegGulevskyy/better-ts-errors.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
        config = function()
            require("daneharnett.better-ts-errors").init()
        end,
    },
    {
        "rmagatti/auto-session",
        config = function()
            require("daneharnett.autosession").init()
        end,
    },
    -- trialling fzf-lua because telescope can be slow for my large repos
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("fzf-lua").setup({})

            vim.keymap.set({ "n", "v", "i" }, "<C-x><C-f>", function()
                require("fzf-lua").complete_path()
            end, { silent = true, desc = "Fuzzy complete path" })

            vim.keymap.set({ "n", "v", "i" }, "<C-x><C-x>", function()
                require("fzf-lua").complete_path({
                    cmd = "fd --type=d --hidden --exclude=.git --exclude=node_modules",
                })
            end, { silent = true, desc = "Fuzzy complete directory path" })
        end,
    },
    {
        "sindrets/diffview.nvim",
    },
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup(plugins)
