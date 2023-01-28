local plugins = {
    -- treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        init = function()
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
        init = function()
            require("daneharnett.biscuits").init()
        end,
    },
    -- A collection of language packs for Vim.
    {
        "sheerun/vim-polyglot",
    },
    -- theme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        cond = not vim.g.vscode,
        init = function()
            require("daneharnett.catppuccin").init()
        end,
    },
    -- buffer line (top of buffer)
    {
        "akinsho/bufferline.nvim",
        init = function()
            require("daneharnett.bufferline").init()
        end,
        version = "v2.8.2",
    },
    -- status line (bottom of buffer)
    {
        "nvim-lualine/lualine.nvim",
        cond = not vim.g.vscode,
        init = function()
            require("daneharnett.lualine").init()
        end,
        dependencies = {
            {
                "kyazdani42/nvim-web-devicons",
            },
        },
    },
    -- lsp
    {
        "neovim/nvim-lspconfig",
        init = function()
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
        },
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = {
            {
                "jay-babu/mason-null-ls.nvim",
            },
        },
        init = function()
            require("daneharnett.null-ls").init()
        end,
    },
    {
        "glepnir/lspsaga.nvim",
        dependencies = {
            {
                "neovim/nvim-lspconfig",
                commit = nvim_lspconfig_commit,
            },
        },
        event = "BufRead",
        init = function()
            require("daneharnett.lspsaga").init()
        end,
    },
    -- completion
    {
        "hrsh7th/nvim-cmp",
        init = function()
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
        init = function()
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
        init = function()
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
        init = function()
            require("daneharnett.trouble").init()
        end,
        dependencies = {
            {
                "kyazdani42/nvim-web-devicons",
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
        init = function()
            require("daneharnett.comment").init()
        end,
    },
    -- autopairs
    {
        "windwp/nvim-autopairs",
        init = function()
            require("daneharnett.autopairs").init()
        end,
    },
    -- terminal
    {
        "akinsho/toggleterm.nvim",
        init = function()
            require("daneharnett.toggleterm").init()
        end,
    },
    -- run tests
    {
        "vim-test/vim-test",
        init = function()
            require("daneharnett.tests").init()
        end,
    },
    -- show colors visually
    {
        "norcalli/nvim-colorizer.lua",
        init = function()
            require("daneharnett.colorizer").init()
        end,
    },
    -- git
    {
        "lewis6991/gitsigns.nvim",
        init = function()
            require("daneharnett.gitsigns").init()
        end,
    },
    {
        "tpope/vim-fugitive",
    },
    {
        "APZelos/blamer.nvim",
        init = function()
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
