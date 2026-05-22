local M = {}

M.keymap = function(mode, key, result, desc)
    desc = desc or ""
    vim.keymap.set(mode, key, result, {
        desc = desc,
        noremap = true,
        silent = true,
    })
end

M.buffer_keymap = function(bufnr, mode, key, result)
    vim.keymap.set(mode, key, result, { buffer = bufnr, noremap = true, silent = true })
end

M.create_format_on_save_autocmd = function(augroup_name, bufnr, timeout_ms)
    timeout_ms = timeout_ms or 1000

    local group = vim.api.nvim_create_augroup(augroup_name .. "FormatOnSave", { clear = false })
    vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
            vim.lsp.buf.format({ timeout_ms = timeout_ms })
        end,
        group = group,
    })
end

M.get_typescript_filetypes = function()
    return { "typescript", "typescriptreact", "typescript.tsx" }
end

M.has_deno_config = function(fname)
    local lspconfig_util_status_ok, lspconfig_util = pcall(require, "lspconfig.util")
    if not lspconfig_util_status_ok then
        return false
    end
    return lspconfig_util.root_pattern("deno.json", "deno.jsonc")(fname)
end

M.has_eslint_config = function(fname)
    local lspconfig_util_status_ok, lspconfig_util = pcall(require, "lspconfig.util")
    if not lspconfig_util_status_ok then
        return false
    end
    return lspconfig_util.root_pattern("eslintrc.js", "eslint.config.js", "eslint.config.mjs")(fname)
end

M.has_tsconfig = function(fname)
    local lspconfig_util_status_ok, lspconfig_util = pcall(require, "lspconfig.util")
    if not lspconfig_util_status_ok then
        return false
    end
    return lspconfig_util.root_pattern("tsconfig.json")(fname)
end

M.is_git_repo = function(fname)
    local git_ancestor = vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
    if git_ancestor then
        return git_ancestor
    end
    return false
end

M.command_exists = function(cmd)
    local check_cmd = "command -v " .. cmd
    local null_device = "/dev/null"

    local result = os.execute(check_cmd .. " > " .. null_device .. " 2>&1")

    -- Handle Lua version differences for os.execute's return value
    if type(result) == "boolean" then
        return result -- Lua 5.2+ returns true on success
    else
        return result == 0 -- Lua 5.1 returns a status code (0 = success)
    end
end

return M
