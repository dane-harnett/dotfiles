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
        version = "^3",
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
            {
                "hrsh7th/cmp-nvim-lsp",
            },
            {
                "j-hui/fidget.nvim",
            },
            {
                "b0o/schemastore.nvim",
            },
        },
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = {
            {
                "jay-babu/mason-null-ls.nvim",
            },
        },
        config = function()
            require("daneharnett.null-ls").init()
        end,
    },
    {
        "glepnir/lspsaga.nvim",
        config = function()
            require("daneharnett.lspsaga").init()
        end,
        dependencies = {
            {
                "neovim/nvim-lspconfig",
            },
        },
        event = "BufRead",
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
        },
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
