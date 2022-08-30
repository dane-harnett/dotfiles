local execute = vim.api.nvim_command
local fn = vim.fn
-- ensure that packer is installed
local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute("packadd packer.nvim")
end
vim.cmd("packadd packer.nvim")
local packer = require("packer")
local util = require("packer.util")
packer.init({
    package_root = util.join_paths(vim.fn.stdpath("data"), "site", "pack"),
})
--- startup and add configure plugins
packer.startup(function()
    local use = use
    -- add your plugins here like:
    -- use 'neovim/nvim-lspconfig'

    -- treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        requires = {
            -- This is a basic completion source based on the treesitter api of neovim.
            "nvim-treesitter/completion-treesitter",
        },
        config = function()
            require("daneharnett.treesitter")
        end,
    })
    use("nvim-treesitter/nvim-treesitter-context")
    use("nvim-treesitter/playground")

    -- A collection of language packs for Vim.
    use("sheerun/vim-polyglot")

    -- theme
    use({
        "EdenEast/nightfox.nvim",
        config = function()
            -- Don't apply this colorscheme in vscode
            if not vim.g.vscode then
                vim.cmd("colorscheme nightfox")
            end
        end,
    })

    -- status line (bottom of buffer)
    use({
        "nvim-lualine/lualine.nvim",
        requires = {
            "kyazdani42/nvim-web-devicons",
            opt = true,
        },
        config = function()
            -- Don't setup this plugin in vscode
            if not vim.g.vscode then
                require("lualine").setup()
            end
        end,
    })

    -- buffer line (top of buffer)
    use({
        "akinsho/bufferline.nvim",
        config = function()
            require("daneharnett.bufferline")
        end,
        tag = "v2.8.2",
    })

    -- js/ts
    -- use 'leafgarland/typescript-vim'
    -- use 'pangloss/vim-javascript'
    -- use 'peitalin/vim-jsx-typescript'
    -- use {
    --   'prettier/vim-prettier',
    --   run = 'yarn install'
    -- }

    -- lsp
    use({
        "neovim/nvim-lspconfig",
        requires = {
            "anott03/nvim-lspinstall",
            "hrsh7th/cmp-nvim-lsp",
            "nvim-lua/lsp-status.nvim",
        },
        config = function()
            require("daneharnett.lsp")
        end,
    })

    use({
        "tami5/lspsaga.nvim",
        requires = {
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("daneharnett.lspsaga")
        end,
    })
    use({
        "jose-elias-alvarez/null-ls.nvim",
        requires = {
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("daneharnett.null-ls")
        end,
    })

    -- completion
    use({
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "onsails/lspkind-nvim",
        },
        config = function()
            require("daneharnett.completion")
        end,
    })

    use({
        "kyazdani42/nvim-tree.lua",
        config = function()
            require("daneharnett.nvim-tree")
        end,
    })

    -- telescope
    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        },
        config = function()
            require("daneharnett.telescope")
        end,
    })

    -- use 'jremmen/vim-ripgrep'

    use({
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup({})
        end,
    })

    -- editorconfig
    use("editorconfig/editorconfig-vim")

    -- vim-smoothie for smooth scrolling
    use("psliwka/vim-smoothie")

    -- comments
    use({
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    })

    -- autopairs
    use("jiangmiao/auto-pairs")

    -- terminal
    use({
        "akinsho/toggleterm.nvim",
        config = function()
            require("daneharnett.toggleterm")
        end,
    })

    use({
        "vim-test/vim-test",
        config = function()
            require("daneharnett.tests")
        end,
    })

    use({
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({
                typescriptreact = { css = true },
            })
        end,
    })

    use({
        "lewis6991/gitsigns.nvim",
        config = function()
            require("daneharnett.gitsigns")
        end,
    })

    use("tpope/vim-fugitive")
    use({
        "APZelos/blamer.nvim",
        config = function()
            vim.g.blamer_enabled = 1
        end,
    })
end)
