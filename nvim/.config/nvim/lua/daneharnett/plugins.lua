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
    "https://github.com/norcalli/nvim-colorizer.lua",
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
require("daneharnett.colorizer").init()
require("daneharnett.gitsigns").init()
require("daneharnett.blamer").init()
require("daneharnett.spectre").init()
require("daneharnett.better-ts-errors").init()
require("daneharnett.telescope").init()

local conform_group = vim.api.nvim_create_augroup("ConformLoader", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    group = conform_group,
    once = true,
    callback = function()
        require("daneharnett.formatting").init()
    end,
})
local nvimlint_group = vim.api.nvim_create_augroup("NvimLintLoader", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    group = nvimlint_group,
    once = true,
    callback = function()
        require("daneharnett.linting").init()
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "Load Lspsaga and dependencies when LSP attaches",
    once = true,
    callback = function()
        require("daneharnett.lspsaga").init()
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    once = true,
    callback = function()
        require("lazydev").setup({
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        })
    end,
})

-- TODO: put this in a fzf.init()
require("fzf-lua").setup({})

vim.keymap.set({ "n", "v", "i" }, "<C-x><C-f>", function()
    require("fzf-lua").complete_path()
end, { silent = true, desc = "Fuzzy complete path" })

vim.keymap.set({ "n", "v", "i" }, "<C-x><C-x>", function()
    require("fzf-lua").complete_path({
        cmd = "fd --type=d --hidden --exclude=.git --exclude=node_modules",
    })
end, { silent = true, desc = "Fuzzy complete directory path" })


-- TODO: put this in a blink-cmp.init()
require("luasnip.loaders.from_vscode").lazy_load()

require("blink.cmp").setup({
    keymap = {
        preset = "default",
    },
    appearance = {
        nerd_font_variant = "mono",
    },
    completion = {
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
    },
    sources = {
        default = { "lsp", "path", "snippets", "lazydev" },
        providers = {
            lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
        },
    },
    snippets = { preset = "luasnip" },
    fuzzy = { implementation = "prefer_rust" },
    signature = { enabled = true },
})
