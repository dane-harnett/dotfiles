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

    use("wbthomason/packer.nvim")

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
        "catppuccin/nvim",
        as = "catppuccin",
        commit = "047770c18ddf8081873cc6279f640c2dda725bba",
        config = function()
            -- Don't apply this colorscheme in vscode
            if not vim.g.vscode then
                vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
                require("catppuccin").setup()
                vim.cmd("colorscheme catppuccin")
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

    -- status line (bottom of buffer)
    use({
        "nvim-lualine/lualine.nvim",
        commit = "3cf45404d4ab5e3b5da283877f57b676cb78d41d",
        config = function()
            -- Don't setup this plugin in vscode
            if not vim.g.vscode then
                require("lualine").setup({})
            end
        end,
        requires = {
            {
                "kyazdani42/nvim-web-devicons",
                commit = "2d02a56189e2bde11edd4712fea16f08a6656944",
            },
        },
    })

    -- lsp
    use({
        "neovim/nvim-lspconfig",
        commit = "df17834baeba1b8425c15a31cbf52e6b23115c37",
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "denols",
                    "jsonls",
                    "rust_analyzer",
                    "sumneko_lua",
                    "tsserver",
                },
            })
            require("daneharnett.lsp")
            require("fidget").setup({})
        end,
        requires = {
            {
                "williamboman/mason.nvim",
                commit = "bfee884583ea347e5d1467839ac5e08ca01f66a3",
            },
            {
                "williamboman/mason-lspconfig.nvim",
                commit = "e8bd50153b94cc5bbfe3f59fc10ec7c4902dd526",
            },
            {
                "hrsh7th/cmp-nvim-lsp",
                commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8",
            },
            {
                "j-hui/fidget.nvim",
                commit = "44585a0c0085765195e6961c15529ba6c5a2a13b",
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
            },
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
            },
        },
    })

    -- completion
    use({
        "hrsh7th/nvim-cmp",
        commit = "8bbaeda725d5db6e4e1be2867a64b43bf547cf06",
        config = function()
            require("daneharnett.completion")
        end,
        requires = {
            {
                "hrsh7th/cmp-nvim-lsp",
                commit = "59224771f91b86d1de12570b4070fe4ad7cd1eeb",
            },
            {
                "hrsh7th/cmp-buffer",
                commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa",
            },
            {
                "onsails/lspkind-nvim",
                commit = "c68b3a003483cf382428a43035079f78474cd11e",
            },
            {
                "L3MON4D3/LuaSnip",
                commit = "8b25e74761eead3dc47ce04b5e017fd23da7ad7e",
            },
            {
                "saadparwaiz1/cmp_luasnip",
                commit = "18095520391186d634a0045dacaa346291096566",
            },
        },
    })

    use({
        "kyazdani42/nvim-tree.lua",
        commit = "011a7816b8ea1b3697687a26804535f24ece70ec",
        config = function()
            require("daneharnett.nvim-tree")
        end,
    })

    use({
        "ThePrimeagen/harpoon",
        commit = "f4aff5bf9b512f5a85fe20eb1dcf4a87e512d971",
        requires = {
            {
                "nvim-lua/plenary.nvim",
                commit = "a3dafaa937921a4eb2ae65820c3479ab561e9ba3",
            },
        },
    })

    -- telescope
    use({
        "nvim-telescope/telescope.nvim",
        commit = "cabf991b1d3996fa6f3232327fc649bbdf676496",
        config = function()
            require("daneharnett.telescope")
        end,
        requires = {
            {
                "nvim-lua/popup.nvim",
                commit = "b7404d35d5d3548a82149238289fa71f7f6de4ac",
            },
            {
                "nvim-lua/plenary.nvim",
                commit = "a3dafaa937921a4eb2ae65820c3479ab561e9ba3",
            },
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                commit = "6791f74e9f08a9412c43dcba805ecf2f8888bdde",
                run = "make",
            },
        },
    })

    -- use 'jremmen/vim-ripgrep'

    use({
        "folke/trouble.nvim",
        commit = "da61737d860ddc12f78e638152834487eabf0ee5",
        config = function()
            require("trouble").setup({})
        end,
        requires = {
            {
                "kyazdani42/nvim-web-devicons",
                commit = "2d02a56189e2bde11edd4712fea16f08a6656944",
            },
        },
    })

    -- editorconfig
    use({
        "editorconfig/editorconfig-vim",
        commit = "d354117b72b3b43b75a29b8e816c0f91af10efe9",
    })

    -- vim-smoothie for smooth scrolling
    use({
        "psliwka/vim-smoothie",
        commit = "df1e324e9f3395c630c1c523d0555a01d2eb1b7e",
    })

    -- comments
    use({
        "numToStr/Comment.nvim",
        commit = "80e7746e42fa685077a7941e9022308c7ad6adf8",
        config = function()
            require("Comment").setup()
        end,
    })

    -- autopairs
    use({
        "jiangmiao/auto-pairs",
        commit = "39f06b873a8449af8ff6a3eee716d3da14d63a76",
    })

    -- terminal
    use({
        "akinsho/toggleterm.nvim",
        commit = "cd3b4d67112fbc8bee01ea44ba5ad1eea3894714",
        config = function()
            require("daneharnett.toggleterm")
        end,
    })

    use({
        "vim-test/vim-test",
        commit = "2da8d59fdc46d1af7b7105a578d1ace3924d1a7b",
        config = function()
            require("daneharnett.tests")
        end,
    })

    use({
        "norcalli/nvim-colorizer.lua",
        commit = "36c610a9717cc9ec426a07c8e6bf3b3abcb139d6",
        config = function()
            require("colorizer").setup({
                typescriptreact = { css = true },
            })
        end,
    })

    use({
        "lewis6991/gitsigns.nvim",
        commit = "1e107c91c0c5e3ae72c37df8ffdd50f87fb3ebfa",
        config = function()
            require("daneharnett.gitsigns")
        end,
    })

    use({
        "tpope/vim-fugitive",
        commit = "b411b753f805b969cca856e2ae51fdbab49880df",
    })

    use({
        "APZelos/blamer.nvim",
        commit = "f4eb22a9013642c411725fdda945ae45f8d93181",
    })
end)
