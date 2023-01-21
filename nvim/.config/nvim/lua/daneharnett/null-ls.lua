local M = {}

function M.init()
    local status_ok, null_ls = pcall(require, "null-ls")
    if not status_ok then
        return
    end
    local null_ls_utils_status_ok, null_ls_utils = pcall(require, "null-ls.utils")
    if not null_ls_utils_status_ok then
        return
    end
    local mason_registry_status_ok, mason_registry = pcall(require, "mason-registry")
    if not mason_registry_status_ok then
        return
    end

    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    if not mason_registry.is_installed("eslint_d") then
        local mason_registry_eslint_d = mason_registry.get_package("eslint_d")
        if mason_registry_eslint_d then
            print("Installing eslint_d with mason")
            mason_registry_eslint_d:install()
        end
    end

    if not mason_registry.is_installed("prettierd") then
        local mason_registry_prettierd = mason_registry.get_package("prettierd")
        if mason_registry_prettierd then
            print("Installing prettierd with mason")
            mason_registry_prettierd:install()
        end
    end

    local get_match_count = function(filepath, needle)
        local grep_cmd = "cat " .. filepath .. " | grep -c --max-count=1 " .. needle
        local grep_cmd_handle = io.popen(grep_cmd)
        if grep_cmd_handle then
            local grep_result = grep_cmd_handle:read("*a")
            grep_cmd_handle:close()
            -- trim whitespace
            local count_matches = string.gsub(grep_result, "^%s*(.-)%s*$", "%1")
            return tonumber(count_matches)
        end
        return 0
    end
    -- this var is used to cache the result of this function so we don't run
    -- the grep command over and over.
    local is_eslint_project_result = nil
    local is_eslint_project = function(utils)
        if type(is_eslint_project_result) == "boolean" then
            return is_eslint_project_result
        end

        local has_eslintrc_js = utils.root_has_file({ ".eslintrc.js", ".eslintrc.json" })
        if has_eslintrc_js then
            is_eslint_project_result = true
            return true
        end

        local has_package_json = utils.root_has_file({ "package.json" })
        local package_json_has_eslint_config = false
        if has_package_json then
            local filepath = null_ls_utils.path.join({ null_ls_utils.get_root(), "package.json" })

            local count_matches = get_match_count(filepath, "eslintConfig")
            if count_matches >= 1 then
                package_json_has_eslint_config = true
            end
        end

        is_eslint_project_result = package_json_has_eslint_config
        return is_eslint_project_result
    end

    -- A project is an `eslint prettier` project if it's package.json includes
    -- `eslint-plugin-prettier`
    local is_eslint_prettier_project_result = nil
    local is_eslint_prettier_project = function(utils)
        if type(is_eslint_prettier_project_result) == "boolean" then
            return is_eslint_prettier_project_result
        end

        local has_package_json = utils.root_has_file({ "package.json" })
        if has_package_json then
            local filepath = null_ls_utils.path.join({ null_ls_utils.get_root(), "package.json" })

            local count_matches = get_match_count(filepath, "eslint-plugin-prettier")
            if count_matches >= 1 then
                is_eslint_prettier_project_result = true
                return is_eslint_prettier_project_result
            end
        end
        is_eslint_prettier_project_result = false
        return is_eslint_prettier_project_result
    end

    local is_prettier_project_result = nil
    local is_prettier_project = function(utils)
        if type(is_prettier_project_result) == "boolean" then
            return is_prettier_project_result
        end

        if utils.root_has_file({ ".prettierrc" }) then
            is_prettier_project_result = true
            return is_prettier_project_result
        end

        is_prettier_project_result = false
        return is_prettier_project_result
    end

    local is_deno_project = function(utils)
        return utils.root_has_file({ "deno.json" })
    end

    local should_format_with_prettier = function(utils)
        if not is_prettier_project(utils) then
            return false
        end
        if is_eslint_project(utils) and is_eslint_prettier_project(utils) then
            return false
        end
        return true
    end

    null_ls.setup({
        diagnostics_format = "[#{c}] #{m} (#{s})",
        debug = true,
        on_attach = function(_, bufnr)
            local group = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                    -- Set the timeout to 10s as it kept timing out for me.
                    vim.lsp.buf.format({ timeout_ms = 10000 })
                end,
                group = group,
            })
        end,
        sources = {
            -- diagnostic sources
            diagnostics.eslint_d.with({
                -- We only want this source to apply when the project uses eslint.
                condition = is_eslint_project,
                timeout = -1,
            }),
            -- formatting sources
            formatting.deno_fmt.with({
                condition = is_deno_project,
                timeout = -1,
            }),
            formatting.prettierd.with({
                -- We only want this source to apply when the project uses prettier
                -- and doesn't use eslint, if eslint is used it should be configured
                -- with eslint-plugin-prettier.
                condition = should_format_with_prettier,
                timeout = -1,
            }),
            formatting.eslint_d.with({
                -- We only want this source to apply when the project uses eslint.
                condition = is_eslint_project,
                timeout = -1,
            }),
            formatting.stylua,
        },
    })
end

return M
