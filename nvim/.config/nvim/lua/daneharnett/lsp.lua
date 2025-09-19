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
    eslint = function()
        local lspconfig_util_status_ok, lspconfig_util = pcall(require, "lspconfig.util")
        if not lspconfig_util_status_ok then
            return
        end

        return {
            filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
            root_dir = lspconfig_util.root_pattern("eslintrc.js"),
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
                    hint = {
                        enable = true,
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
    rust_analyzer = function()
        return {}
    end,
    nil_ls = function()
        return {}
    end,
    ts_ls = function()
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
            -- if the project is a typescript project (has a tsconfig.json)
            -- configure for use in monorepos, spawn one process at the root of
            -- the project (the directory with `.git`).
            -- otherwise, fallback to the location where the tsconfig.json lives
            -- otherwise, it's not a typescript project we want to use this lsp
            -- with.
            root_dir = function(startpath)
                local tsconfig_ancestor = lspconfig_util.root_pattern("tsconfig.json")(startpath)
                if not tsconfig_ancestor then
                    return nil
                end

                local git_ancestor = vim.fs.dirname(vim.fs.find(".git", { path = startpath, upward = true })[1])
                if not git_ancestor then
                    return tsconfig_ancestor
                end

                return git_ancestor
            end,
            single_file_support = false,
            typescript = {
                inlayHints = {
                    includeInlayEnumMemberValueHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayParameterNameHints = "all",
                    includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayVariableTypeHints = true,
                },
            },
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
    local mason_tool_installer_status_ok, mason_tool_installer = pcall(require, "mason-tool-installer")
    if not mason_tool_installer_status_ok then
        return
    end
    local blink_cmp_status_ok, blink_cmp = pcall(require, "blink.cmp")
    if not blink_cmp_status_ok then
        return
    end

    local client_capabilities = vim.lsp.protocol.make_client_capabilities()
    local blink_cmp_capabilities = blink_cmp.get_lsp_capabilities()
    local capabilities = vim.tbl_deep_extend("force", client_capabilities, blink_cmp_capabilities)

    local servers = {}
    for server_name, make_server_config in pairs(server_configs) do
        local server_config = make_server_config()
        if server_config then
            servers[server_name] = vim.tbl_extend("keep", server_config, {
                capabilities = capabilities,
            })
        end
    end

    mason.setup()
    mason_lspconfig.setup({
        automatic_installation = false,
        ensure_installed = vim.tbl_keys(servers),
        handlers = {
            function(server_name)
                lspconfig[server_name].setup(servers[server_name])
            end,
        },
    })
    mason_tool_installer.setup({
        ensure_installed = {
            "prettierd",
            "stylua",
            "isort",
            "black",
            "pylint",
        },
    })

    local fidget_status_ok, fidget = pcall(require, "fidget")
    if not fidget_status_ok then
        return
    end
    fidget.setup({})

    M.create_lspattach_autocmd()
end
M.create_lspattach_autocmd = function()
    local group = vim.api.nvim_create_augroup("daneharnett-lsp-attach", { clear = true })
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
            local client = vim.lsp.get_client_by_id(event.data.client_id)
            local bufnr = event.buf
            M.setup_diagnostics()
            M.attach_keymaps_to_buffer(bufnr)

            if client and client.name == "rust_analyzer" then
                local utils = require("daneharnett.utils")
                utils.create_format_on_save_autocmd("Rust", bufnr)
            end
            if client and client.name == "ts_ls" then
                -- Need to disable formatting because we will use eslint or prettier instead
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
            end
        end,
        group = group,
    })
end
M.setup_diagnostics = function()
    local config = {
        -- disable virtual text
        virtual_text = false,
        -- show signs
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = "",
                [vim.diagnostic.severity.WARN] = "",
                [vim.diagnostic.severity.HINT] = "",
                [vim.diagnostic.severity.INFO] = "",
            },
            texthl = {
                [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
                [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
                [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
                [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
            },
            numhl = {
                [vim.diagnostic.severity.ERROR] = "",
                [vim.diagnostic.severity.WARN] = "",
                [vim.diagnostic.severity.HINT] = "",
                [vim.diagnostic.severity.INFO] = "",
            },
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
    local utils = require("daneharnett.utils")
    local my_lspsaga = require("daneharnett.lspsaga")
    local my_trouble = require("daneharnett.trouble")
    my_lspsaga.attach_keymaps_to_buffer(bufnr)
    my_trouble.attach_keymaps_to_buffer(bufnr)

    utils.buffer_keymap(bufnr, { "n", "v" }, "<leader>ca", "")

    if vim.lsp.inlay_hint then
        utils.buffer_keymap(bufnr, "n", "<leader>uh", function()
            vim.lsp.inlay_hint(bufnr, nil)
        end)
    end
end

return M
