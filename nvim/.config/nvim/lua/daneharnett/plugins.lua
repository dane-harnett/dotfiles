vim.pack.add({
    "https://github.com/catppuccin/nvim",
    "https://github.com/rcarriga/nvim-notify",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/nvim-treesitter/nvim-treesitter-context",
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/akinsho/bufferline.nvim",
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/folke/lazydev.nvim",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    {
        src = "https://github.com/j-hui/fidget.nvim",
        version = "legacy",
    },
    "https://github.com/b0o/schemastore.nvim",
    {
        src = "https://github.com/saghen/blink.cmp",
        version = "v1.10.1",
    },
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/rshkarin/mason-nvim-lint",
    "https://github.com/nvim-tree/nvim-tree.lua",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/ThePrimeagen/harpoon",
    "https://github.com/folke/trouble.nvim",
    "https://github.com/editorconfig/editorconfig-vim",
    "https://github.com/psliwka/vim-smoothie",
    "https://github.com/numToStr/Comment.nvim",
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/akinsho/toggleterm.nvim",
    "https://github.com/vim-test/vim-test",
    "https://github.com/brenoprata10/nvim-highlight-colors",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/tpope/vim-fugitive",
    "https://github.com/APZelos/blamer.nvim",
    "https://github.com/nvim-pack/nvim-spectre",
    "https://github.com/folke/todo-comments.nvim",
    "https://github.com/MunifTanjim/nui.nvim",
    "https://github.com/OlegGulevskyy/better-ts-errors.nvim",
    "https://github.com/ibhagwan/fzf-lua",
    "https://github.com/sindrets/diffview.nvim",
    "https://github.com/nvim-lua/popup.nvim",
    "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
    "https://github.com/nvim-telescope/telescope-ui-select.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/stevearc/conform.nvim",
    "https://github.com/mfussenegger/nvim-lint",
    "https://github.com/nvimdev/lspsaga.nvim",
    "https://github.com/rafamadriz/friendly-snippets",
    {
        src = "https://github.com/L3MON4D3/LuaSnip",
        version = "v2.4.1",
    },
    {
        src = "https://github.com/saghen/blink.cmp",
        version = "v1.10.1",
    },
})

require("daneharnett.catppuccin").init()
require("daneharnett.treesitter").init()
require("daneharnett.bufferline").init()
require("daneharnett.lualine").init()
require("daneharnett.lsp").init()
require("daneharnett.nvim-tree").init()
require("daneharnett.trouble").init()
require("daneharnett.comment").init()
require("daneharnett.autopairs").init()
require("daneharnett.toggleterm").init()
require("daneharnett.tests").init()
require("daneharnett.highlight-colors").init()
require("daneharnett.gitsigns").init()
require("daneharnett.blamer").init()
require("daneharnett.spectre").init()
require("daneharnett.better-ts-errors").init()
require("daneharnett.telescope").init()

require("daneharnett.formatting").autocmd()
require("daneharnett.linting").autocmd()
require("daneharnett.lspsaga").autocmd()
require("daneharnett.lazydev").autocmd()

require("daneharnett.fzf").init()
require("daneharnett.blink-cmp").init()
