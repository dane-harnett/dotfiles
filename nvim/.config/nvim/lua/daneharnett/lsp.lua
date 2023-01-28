local M = {}

function M.init()
    local mason_status_ok, mason = pcall(require, "mason")
    if not mason_status_ok then
        return
    end
    local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
    if not mason_lspconfig_status_ok then
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

    M.setup_denols(capabilities)
    M.setup_jsonls(capabilities)
    M.setup_rust_analyzer(capabilities)
    M.setup_sumneko_lua(capabilities)
    M.setup_tsserver(capabilities)

    fidget.setup({})
end

M.setup_diagnostics = function()
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

M.attach_keymaps_to_buffer = function(bufnr)
    local my_lspsaga = require("daneharnett.lspsaga")
    local my_trouble = require("daneharnett.trouble")
    my_lspsaga.attach_keymaps_to_buffer(bufnr)
    my_trouble.attach_keymaps_to_buffer(bufnr)
end

M.make_on_attach = function(opts)
    opts = opts or {}

    return function(client, bufnr)
        M.setup_diagnostics()
        M.attach_keymaps_to_buffer(bufnr)

        if opts.on_after and type(opts.on_after) == "function" then
            opts.on_after(client, bufnr)
        end
    end
end

M.setup_tsserver = function(capabilities)
    local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
    if not lspconfig_status_ok then
        return
    end
    local lspconfig_util_status_ok, lspconfig_util = pcall(require, "lspconfig.util")
    if not lspconfig_util_status_ok then
        return
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
        on_attach = M.make_on_attach({
            on_after = function(client)
                -- Need to disable formatting for tsserver because we will use eslint or prettier instead
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
            end,
        }),
        -- configure tsserver for use in monorepos, spawn one process at the root.
        -- check for tsconfig.json so we don't conflict with deno projects.
        root_dir = function(filepath)
            return (
                lspconfig_util.root_pattern(".git")(filepath)
                and lspconfig_util.root_pattern("tsconfig.json")(filepath)
            )
        end,
    })
end

M.setup_denols = function(capabilities)
    local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
    if not lspconfig_status_ok then
        return
    end
    local lspconfig_util_status_ok, lspconfig_util = pcall(require, "lspconfig.util")
    if not lspconfig_util_status_ok then
        return
    end

    lspconfig.denols.setup({
        capabilities = capabilities,
        filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
        on_attach = M.make_on_attach(),
        root_dir = lspconfig_util.root_pattern("deno.json", "deno.jsonc"),
    })
end

M.setup_jsonls = function(capabilities)
    local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
    if not lspconfig_status_ok then
        return
    end

    lspconfig.jsonls.setup({
        capabilities = capabilities,
        filetypes = { "json", "jsonc" },
        on_attach = M.make_on_attach(),
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
end

M.setup_sumneko_lua = function(capabilities)
    local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
    if not lspconfig_status_ok then
        return
    end

    local runtime_path = vim.split(package.path, ";")
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")

    lspconfig.sumneko_lua.setup({
        capabilities = capabilities,
        on_attach = M.make_on_attach(),
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
end

M.setup_rust_analyzer = function(capabilities)
    local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
    if not lspconfig_status_ok then
        return
    end

    lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
        on_attach = M.make_on_attach({
            on_after = function(_, bufnr)
                -- use rust_analyzer to format on save
                local group = vim.api.nvim_create_augroup("RustLspFormatting", { clear = false })
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format()
                    end,
                    group = group,
                })
            end,
        }),
    })
end

return M
