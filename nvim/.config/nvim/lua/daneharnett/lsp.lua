local M = {}

function M.init()
    local utils = require("daneharnett.utils")

    local mason_status_ok, mason = pcall(require, "mason")
    if not mason_status_ok then
        return
    end
    local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
    if not mason_lspconfig_status_ok then
        return
    end
    local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
    if not lspconfig_status_ok then
        return
    end
    local lspconfig_util_status_ok, lspconfig_util = pcall(require, "lspconfig.util")
    if not lspconfig_util_status_ok then
        return
    end
    local cmp_nvim_lsp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if not cmp_nvim_lsp_status_ok then
        return
    end
    local fidget_status_ok, fidget = pcall(require, "fidget")
    if not fidget_status_ok then
        return
    end

    mason.setup()
    mason_lspconfig.setup({
        ensure_installed = {
            "denols",
            "jsonls",
            "rust_analyzer",
            "sumneko_lua",
            "tsserver",
        },
    })

    local client_capabilities = vim.lsp.protocol.make_client_capabilities()
    local capabilities = cmp_nvim_lsp.default_capabilities(client_capabilities)

    -- Diagnostics
    local load_diagnostics = function()
        local signs = {
            { name = "DiagnosticSignError", text = "" },
            { name = "DiagnosticSignWarn", text = "" },
            { name = "DiagnosticSignHint", text = "" },
            { name = "DiagnosticSignInfo", text = "" },
        }

        for _, sign in ipairs(signs) do
            vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
        end

        local config = {
            -- disable virtual text
            virtual_text = false,
            -- show signs
            signs = {
                active = signs,
            },
            update_in_insert = true,
            underline = true,
            severity_sort = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        }
        vim.diagnostic.config(config)
    end

    -- setup language servers here

    local load_mappings = function(bufnr)
        -- Trouble
        utils.current_buffer_keymap("n", "<leader>gr", "<cmd>TroubleToggle lsp_references<cr>")

        -- Lspsaga
        -- lsp provider to find the cursor word definition and reference
        utils.current_buffer_keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")

        -- code action
        utils.current_buffer_keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")

        -- show hover doc
        utils.current_buffer_keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")

        -- Call hierarchy
        utils.current_buffer_keymap("n", "<leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
        utils.current_buffer_keymap("n", "<leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

        -- scroll down hover doc or scroll in definition preview
        utils.current_buffer_keymap("n", "<C-f>", ':lua require"lspsaga.action".smart_scroll_with_saga(1)<CR>')

        -- scroll up hover doc
        utils.current_buffer_keymap("n", "<C-b>", ':lua require"lspsaga.action".smart_scroll_with_saga(-1)<CR>')

        -- show signature help
        -- utils.("n", "gs", ':lua require"lspsaga.signaturehelp".signature_help()<CR>')

        -- rename
        utils.current_buffer_keymap("n", "gr", "<cmd>Lspsaga rename<CR>")

        -- peek definition
        utils.current_buffer_keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>")

        -- go to definition
        utils.current_buffer_keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>")

        -- show line diagnostics
        utils.current_buffer_keymap("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")

        -- show cursor diagnostics
        utils.current_buffer_keymap("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

        -- Show buffer diagnostics
        utils.current_buffer_keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")

        -- jump to diagnostic
        utils.current_buffer_keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
        utils.current_buffer_keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

        -- Diagnostic jump with filter like Only jump to error
        utils.current_buffer_keymap("n", "[E", function()
            require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
        end)
        utils.current_buffer_keymap("n", "]E", function()
            require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
        end)

        -- floating terminal
        utils.current_buffer_keymap({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")

        local group = vim.api.nvim_create_augroup("ShowDiagnosticsOnHover", { clear = true })
        vim.api.nvim_create_autocmd("CursorHold", {
            buffer = bufnr,
            command = "Lspsaga show_line_diagnostics",
            group = group,
        })
    end

    local on_attach = function(client, bufnr)
        load_mappings(bufnr)
        load_diagnostics()
        -- Need to disable formatting for tsserver because we will use eslint or prettier instead
        if client.name == "tsserver" then
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
        end
    end

    -- typescript
    lspconfig.tsserver.setup({
        capabilities = capabilities,
        filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
        init_options = {
            maxTsServerMemory = 12288,
            preferences = {
                importModuleSpecifierPreference = "relative",
            },
        },
        on_attach = on_attach,
        -- configure tsserver for use in monorepos, spawn one process at the root.
        -- check for tsconfig.json so we don't conflict with deno projects.
        root_dir = function(filepath)
            return (
                lspconfig_util.root_pattern(".git")(filepath)
                    and lspconfig_util.root_pattern("tsconfig.json")(filepath)
                )
        end,
    })
    -- deno
    lspconfig.denols.setup({
        capabilities = capabilities,
        filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
        on_attach = on_attach,
        root_dir = lspconfig_util.root_pattern("deno.json", "deno.jsonc"),
    })

    -- json
    -- install json language server with the following command:
    -- $ npm install -g vscode-json-languageserver
    lspconfig.jsonls.setup({
        capabilities = capabilities,
        filetypes = { "json", "jsonc" },
        on_attach = on_attach,
        settings = {
            json = {
                -- Schemas https://www.schemastore.org
                schemas = {
                    {
                        fileMatch = { "package.json" },
                        url = "https://json.schemastore.org/package.json",
                    },
                    {
                        fileMatch = { "manifest.json", "manifest.webmanifest" },
                        url = "https://json.schemastore.org/web-manifest-combined.json",
                    },
                    {
                        fileMatch = { "tsconfig*.json" },
                        url = "https://json.schemastore.org/tsconfig.json",
                    },
                    {
                        fileMatch = {
                            ".prettierrc",
                            ".prettierrc.json",
                            "prettier.config.json",
                        },
                        url = "https://json.schemastore.org/prettierrc.json",
                    },
                    {
                        fileMatch = { ".eslintrc", ".eslintrc.json" },
                        url = "https://json.schemastore.org/eslintrc.json",
                    },
                    {
                        fileMatch = { ".babelrc", ".babelrc.json", "babel.config.json" },
                        url = "https://json.schemastore.org/babelrc.json",
                    },
                    {
                        fileMatch = { "lerna.json" },
                        url = "https://json.schemastore.org/lerna.json",
                    },
                    {
                        fileMatch = { "now.json", "vercel.json" },
                        url = "https://json.schemastore.org/now.json",
                    },
                    {
                        fileMatch = {
                            ".stylelintrc",
                            ".stylelintrc.json",
                            "stylelint.config.json",
                        },
                        url = "http://json.schemastore.org/stylelintrc.json",
                    },
                },
            },
        },
    })

    -- lua
    local runtime_path = vim.split(package.path, ";")
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")

    lspconfig.sumneko_lua.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                    path = runtime_path,
                },
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    })

    -- rust
    lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
        -- custom on_attach here because I'm using rust_analyzer to format.
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            local group = vim.api.nvim_create_augroup("RustLspFormatting", { clear = true })
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format()
                end,
                group = group,
            })
        end,
    })

    fidget.setup({})
end

return M
