local utils = require("daneharnett.utils")

-- lsp config and setup
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

local client_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = cmp_nvim_lsp.update_capabilities(client_capabilities)

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
    -- utils.current_buffer_keymap('n', 'K', vim.lsp.buf.hover)
    utils.current_buffer_keymap("n", "gd", vim.lsp.buf.definition)
    utils.current_buffer_keymap("n", "gt", vim.lsp.buf.type_definition)
    utils.current_buffer_keymap("n", "gi", vim.lsp.buf.implementation)
    -- utils.current_buffer_keymap('n', 'gr', vim.lsp.buf.references)
    -- utils.current_buffer_keymap('n', '<leader>r', vim.lsp.buf.rename)
    -- utils.current_buffer_keymap('n', '<leader>ca', vim.lsp.buf.code_action)
    utils.current_buffer_keymap("n", "<leader>ds", vim.diagnostic.open_float)

    -- Trouble
    utils.current_buffer_keymap("n", "<leader>gr", "<cmd>TroubleToggle lsp_references<cr>")

    -- Lspsaga
    utils.current_buffer_keymap("n", "gr", "<cmd>Lspsaga rename<cr>")
    utils.current_buffer_keymap("n", "gx", "<cmd>Lspsaga code_action<cr>")
    utils.current_buffer_keymap("x", "gx", ":<c-u>Lspsaga range_code_action<cr>")
    utils.current_buffer_keymap("n", "K", "<cmd>Lspsaga hover_doc<cr>")
    -- utils.current_buffer_keymap("n", "<leader>ds", "<cmd>Lspsaga show_line_diagnostics<cr>")
    utils.current_buffer_keymap("n", "<leader>dn", "<cmd>Lspsaga diagnostic_jump_next<cr>")
    utils.current_buffer_keymap("n", "<leader>dp", "<cmd>Lspsaga diagnostic_jump_prev<cr>")
    -- utils.current_buffer_keymap("n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<cr>")
    -- utils.current_buffer_keymap("n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<cr>")

    local group = vim.api.nvim_create_augroup("ShowDiagnosticsOnHover", { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        command = "Lspsaga show_line_diagnostics",
        group = group,
    })
end

local on_attach = function(client, bufnr)
    print("Attaching to " .. client.name .. " in buffer " .. bufnr)
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
    cmd = { "vscode-json-languageserver", "--stdio" },
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "json", "jsonc" },
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
