local plugins = {
    -- treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        commit = "372177fb996b7d94246fd214cc44573116704618",
        init = function()
            require("daneharnett.treesitter").init()
        end,
    },
    {
        "nvim-treesitter/completion-treesitter",
        commit = "45c9b2faff4785539a0d0c655440c2465fed985a",
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        commit = "cacee4828152dd3a83736169ae61bbcd29a3d213",
    },
    {
        "nvim-treesitter/playground",
        commit = "90d2b3e1729363f96ce2c23f16129534df893bbf",
    },
    -- nvim-biscuits
    {
        "code-biscuits/nvim-biscuits",
        commit = "25a880605fa4533b7075c54a0fdb5f0a25bc4f84",
        init = function()
            require("daneharnett.biscuits").init()
        end,
    },
    -- A collection of language packs for Vim.
    {
        "sheerun/vim-polyglot",
        commit = "38282d58387cff48ac203f6912c05e4c8686141b",
    },
    -- theme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        commit = "047770c18ddf8081873cc6279f640c2dda725bba",
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
        commit = "3cf45404d4ab5e3b5da283877f57b676cb78d41d",
        init = function()
            require("daneharnett.lualine").init()
        end,
        dependencies = {
            {
                "kyazdani42/nvim-web-devicons",
                commit = "2d02a56189e2bde11edd4712fea16f08a6656944",
            },
        },
    },
    -- lsp
    {
        "neovim/nvim-lspconfig",
        commit = "d228bcf7cd94611929482a09e114a42c41fe81a8",
        init = function()
            require("daneharnett.lsp").init()
        end,
        dependencies = {
            {
                "williamboman/mason.nvim",
                commit = "e7303a1632c004ebd2dcd0be1aaa4354586c030b",
            },
            {
                "williamboman/mason-lspconfig.nvim",
                commit = "c29f9a9f9b01528ca6a44cd14814f5af20778f7a",
            },
            {
                "hrsh7th/cmp-nvim-lsp",
                commit = "59224771f91b86d1de12570b4070fe4ad7cd1eeb",
            },
            {
                "j-hui/fidget.nvim",
                commit = "44585a0c0085765195e6961c15529ba6c5a2a13b",
            },
        },
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        commit = "ef3d4a438f96865e3ae018e33ed30156a955ed00",
        dependencies = {
            {
                "jay-babu/mason-null-ls.nvim",
                commit = "93946aef86b1409958c97ee5feaf30bdd1053e24",
            },
        },
        init = function()
            require("daneharnett.null-ls").init()
        end,
    },
    {
        "glepnir/lspsaga.nvim",
        commit = "ac134041da57f7592a46775f235ed84880bc0b27",
        dependencies = {
            {
                "neovim/nvim-lspconfig",
                commit = "d228bcf7cd94611929482a09e114a42c41fe81a8",
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
        commit = "8bbaeda725d5db6e4e1be2867a64b43bf547cf06",
        init = function()
            require("daneharnett.completion").init()
        end,
        dependencies = {
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
    },
    -- file-tree sidebar explorer
    {
        "kyazdani42/nvim-tree.lua",
        commit = "011a7816b8ea1b3697687a26804535f24ece70ec",
        init = function()
            require("daneharnett.nvim-tree").init()
        end,
    },
    -- harpoon
    {
        "ThePrimeagen/harpoon",
        commit = "f4aff5bf9b512f5a85fe20eb1dcf4a87e512d971",
        dependencies = {
            {
                "nvim-lua/plenary.nvim",
                commit = "a3dafaa937921a4eb2ae65820c3479ab561e9ba3",
            },
        },
    },
    -- telescope
    {
        "nvim-telescope/telescope.nvim",
        commit = "cabf991b1d3996fa6f3232327fc649bbdf676496",
        init = function()
            require("daneharnett.telescope").init()
        end,
        dependencies = {
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
                build = "make",
            },
        },
    },
    -- trouble
    {
        "folke/trouble.nvim",
        commit = "da61737d860ddc12f78e638152834487eabf0ee5",
        init = function()
            require("daneharnett.trouble").init()
        end,
        dependencies = {
            {
                "kyazdani42/nvim-web-devicons",
                commit = "2d02a56189e2bde11edd4712fea16f08a6656944",
            },
        },
    },
    -- editorconfig
    {
        "editorconfig/editorconfig-vim",
        commit = "d354117b72b3b43b75a29b8e816c0f91af10efe9",
    },
    -- vim-smoothie for smooth scrolling
    {
        "psliwka/vim-smoothie",
        commit = "df1e324e9f3395c630c1c523d0555a01d2eb1b7e",
    },
    -- comments
    {
        "numToStr/Comment.nvim",
        commit = "80e7746e42fa685077a7941e9022308c7ad6adf8",
        init = function()
            require("daneharnett.comment").init()
        end,
    },
    -- autopairs
    {
        "windwp/nvim-autopairs",
        commit = "f00eb3b766c370cb34fdabc29c760338ba9e4c6c",
        init = function()
            require("daneharnett.autopairs").init()
        end,
    },
    -- terminal
    {
        "akinsho/toggleterm.nvim",
        commit = "cd3b4d67112fbc8bee01ea44ba5ad1eea3894714",
        init = function()
            require("daneharnett.toggleterm").init()
        end,
    },
    -- run tests
    {
        "vim-test/vim-test",
        commit = "2da8d59fdc46d1af7b7105a578d1ace3924d1a7b",
        init = function()
            require("daneharnett.tests").init()
        end,
    },
    -- show colors visually
    {
        "norcalli/nvim-colorizer.lua",
        commit = "36c610a9717cc9ec426a07c8e6bf3b3abcb139d6",
        init = function()
            require("daneharnett.colorizer").init()
        end,
    },
    -- git
    {
        "lewis6991/gitsigns.nvim",
        commit = "1e107c91c0c5e3ae72c37df8ffdd50f87fb3ebfa",
        init = function()
            require("daneharnett.gitsigns").init()
        end,
    },
    {
        "tpope/vim-fugitive",
        commit = "b411b753f805b969cca856e2ae51fdbab49880df",
    },
    {
        "APZelos/blamer.nvim",
        commit = "f4eb22a9013642c411725fdda945ae45f8d93181",
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
