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
        commit = "f0c9a186eab06d7e4dcd78c973dcb60b702ac5d2",
        config = function()
            require("daneharnett.treesitter")
        end,
        requires = {
            -- This is a basic completion source based on the treesitter api of neovim.
            {
                "nvim-treesitter/completion-treesitter",
                commit = "45c9b2faff4785539a0d0c655440c2465fed985a",
            },
        },
    })
    use({
        "nvim-treesitter/nvim-treesitter-context",
        commit = "8e88b67d0dc386d6ba1b3d09c206f19a50bc0625",
    })
    use({
        "nvim-treesitter/playground",
        commit = "90d2b3e1729363f96ce2c23f16129534df893bbf",
    })

    -- A collection of language packs for Vim.
    use({
        "sheerun/vim-polyglot",
        commit = "38282d58387cff48ac203f6912c05e4c8686141b",
    })

    -- theme
    use({
        "EdenEast/nightfox.nvim",
        commit = "e2f961859cbfb2ba38147dc59fdd2314992c8b62",
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
        commit = "3cf45404d4ab5e3b5da283877f57b676cb78d41d",
        config = function()
            -- Don't setup this plugin in vscode
            if not vim.g.vscode then
                require("lualine").setup()
            end
        end,
        requires = {
            {
                "kyazdani42/nvim-web-devicons",
                commit = "2d02a56189e2bde11edd4712fea16f08a6656944",
            }
        },
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
        commit = "df17834baeba1b8425c15a31cbf52e6b23115c37",
        config = function()
            require("daneharnett.lsp")
        end,
        requires = {
            {
                "anott03/nvim-lspinstall",
                commit = "1d9b385dc4d963b9ee93d4597f6010c4ada4b405",
            },
            {
                "hrsh7th/cmp-nvim-lsp",
                commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8",
            },
            {
                "nvim-lua/lsp-status.nvim",
                commit = "54f48eb5017632d81d0fd40112065f1d062d0629",
            },
        },
    })

    use({
        "tami5/lspsaga.nvim",
        commit = "9ec569a49aa7ff265764081acff9e5da839c13fe",
        config = function()
            require("daneharnett.lspsaga")
        end,
        requires = {
            {
                "neovim/nvim-lspconfig",
                commit = "df17834baeba1b8425c15a31cbf52e6b23115c37",
            }
        },
    })
    use({
        "jose-elias-alvarez/null-ls.nvim",
        commit = "de751688c991216f0d17ced7d5076e0c37fa383f",
        config = function()
            require("daneharnett.null-ls")
        end,
        requires = {
            {
                "neovim/nvim-lspconfig",
                commit = "df17834baeba1b8425c15a31cbf52e6b23115c37",
            }
        },
    })

    -- completion
    use({
        "hrsh7th/nvim-cmp",
        commit = "b5885696b1f2cbdc9f523cc09c2a786919de07d5",
        config = function()
            require("daneharnett.completion")
        end,
        requires = {
            {
                "hrsh7th/cmp-nvim-lsp",
                commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8",
            },
            {
                "hrsh7th/cmp-buffer",
                commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa",
            },
            {
                "onsails/lspkind-nvim",
                commit = "57e5b5dfbe991151b07d272a06e365a77cc3d0e7",
            },
        },
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
        config = function()
            require("trouble").setup({})
        end,
        requires = {
            {
                "kyazdani42/nvim-web-devicons",
                commit = "2d02a56189e2bde11edd4712fea16f08a6656944",
            }
        },
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
