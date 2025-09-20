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
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
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
                "j-hui/fidget.nvim",
                tag = "legacy",
            },
            {
                "b0o/schemastore.nvim",
            },
            {
                "saghen/blink.cmp",
            },
        },
    },
    { -- Autocompletion
        "saghen/blink.cmp",
        event = "VimEnter",
        version = "1.*",
        dependencies = {
            -- Snippet Engine
            {
                "L3MON4D3/LuaSnip",
                version = "2.*",
                build = (function()
                    -- Build Step is needed for regex support in snippets.
                    -- This step is not supported in many windows environments.
                    -- Remove the below condition to re-enable on windows.
                    if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                        return
                    end
                    return "make install_jsregexp"
                end)(),
                dependencies = {
                    -- `friendly-snippets` contains a variety of premade snippets.
                    --    See the README about individual language/framework/plugin snippets:
                    --    https://github.com/rafamadriz/friendly-snippets
                    -- {
                    --   'rafamadriz/friendly-snippets',
                    --   config = function()
                    --     require('luasnip.loaders.from_vscode').lazy_load()
                    --   end,
                    -- },
                },
                opts = {},
            },
            "folke/lazydev.nvim",
        },
        --- @module 'blink.cmp'
        --- @type blink.cmp.Config
        opts = {
            keymap = {
                -- 'default' (recommended) for mappings similar to built-in completions
                --   <c-y> to accept ([y]es) the completion.
                --    This will auto-import if your LSP supports it.
                --    This will expand snippets if the LSP sent a snippet.
                -- 'super-tab' for tab to accept
                -- 'enter' for enter to accept
                -- 'none' for no mappings
                --
                -- For an understanding of why the 'default' preset is recommended,
                -- you will need to read `:help ins-completion`
                --
                -- No, but seriously. Please read `:help ins-completion`, it is really good!
                --
                -- All presets have the following mappings:
                -- <tab>/<s-tab>: move to right/left of your snippet expansion
                -- <c-space>: Open menu or open docs if already open
                -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
                -- <c-e>: Hide menu
                -- <c-k>: Toggle signature help
                --
                -- See :h blink-cmp-config-keymap for defining your own keymap
                preset = "default",

                -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
                --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
            },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = "mono",
            },

            completion = {
                -- By default, you may press `<c-space>` to show the documentation.
                -- Optionally, set `auto_show = true` to show the documentation after a delay.
                documentation = { auto_show = false, auto_show_delay_ms = 500 },
            },

            sources = {
                default = { "lsp", "path", "snippets", "lazydev" },
                providers = {
                    lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
                },
            },

            snippets = { preset = "luasnip" },

            -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
            -- which automatically downloads a prebuilt binary when enabled.
            --
            -- By default, we use the Lua implementation instead, but you may enable
            -- the rust implementation via `'prefer_rust_with_warning'`
            --
            -- See :h blink-cmp-config-fuzzy for more information
            fuzzy = { implementation = "prefer_rust" },

            -- Shows a signature help window while you type arguments for a function
            signature = { enabled = true },
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
    {
        "rshkarin/mason-nvim-lint",
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
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(plugins)
