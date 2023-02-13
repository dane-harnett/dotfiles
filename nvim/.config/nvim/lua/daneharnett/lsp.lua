local M = {}

local server_configs = {
    denols = function()
        local lspconfig_util_status_ok, lspconfig_util = pcall(require, "lspconfig.util")
        if not lspconfig_util_status_ok then
            return
        end

        return {
            filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
            root_dir = lspconfig_util.root_pattern("deno.json", "deno.jsonc"),
        }
    end,
    jsonls = function()
        local schemastore_status_ok, schemastore = pcall(require, "schemastore")
        if not schemastore_status_ok then
            return
        end

        return {
            settings = {
                json = {
                    schemas = schemastore.json.schemas(),
                    validate = { enable = true },
                },
            },
        }
    end,
    lua_ls = function()
        local runtime_path = vim.split(package.path, ";")
        table.insert(runtime_path, "lua/?.lua")
        table.insert(runtime_path, "lua/?/init.lua")

        return {
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
        }
    end,
    quick_lint_js = function()
        return {}
    end,
    rust_analyzer = function()
        return {
            on_attach = M.make_on_attach({
                on_after = function(_, bufnr)
                    local utils = require("daneharnett.utils")
                    utils.create_format_on_save_autocmd("Rust", bufnr)
                end,
            }),
        }
    end,
    tsserver = function()
        local lspconfig_util_status_ok, lspconfig_util = pcall(require, "lspconfig.util")
        if not lspconfig_util_status_ok then
            return
        end

        return {
            filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
            init_options = {
                maxTsServerMemory = 12288,
                preferences = {
                    importModuleSpecifierPreference = "relative",
                },
            },
            on_attach = M.make_on_attach({
                on_after = function(client)
                    -- Need to disable formatting because we will use eslint or prettier instead
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end,
            }),
            -- if the project is a typescript project (has a tsconfig.json)
            -- configure for use in monorepos, spawn one process at the root of
            -- the project (the directory with `.git`).
            -- otherwise, fallback to the location where the tsconfig.json lives
            -- otherwise, it's not a typescript project we want to use this lsp
            -- with.
            root_dir = function(filepath)
                local tsconfig_ancestor = lspconfig_util.root_pattern("tsconfig.json")(filepath)
                if not tsconfig_ancestor then
                    return nil
                end

                local git_ancestor = lspconfig_util.find_git_ancestor(filepath)
                if not git_ancestor then
                    return tsconfig_ancestor
                end

                return git_ancestor
            end,
            single_file_support = false,
        }
    end,
}

function M.init()
    local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
    if not lspconfig_status_ok then
        return
    end
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

    local client_capabilities = vim.lsp.protocol.make_client_capabilities()
    local capabilities =
        vim.tbl_deep_extend("force", client_capabilities, cmp_nvim_lsp.default_capabilities(client_capabilities))

    local servers = {}
    for server_name, make_server_config in pairs(server_configs) do
        local server_config = make_server_config()
        if server_config then
            servers[server_name] = vim.tbl_extend("keep", server_config, {
                capabilities = capabilities,
                on_attach = M.make_on_attach(),
            })
        end
    end

    mason.setup()
    mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(servers),
    })
    mason_lspconfig.setup_handlers({
        function(server_name)
            lspconfig[server_name].setup(servers[server_name])
        end,
    })

    local fidget_status_ok, fidget = pcall(require, "fidget")
    if not fidget_status_ok then
        return
    end
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

return M
