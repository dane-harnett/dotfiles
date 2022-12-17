local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
    return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local is_eslint_project = function(utils)
    return utils.root_has_file({ ".eslintrc.js" })
end

local is_prettier_project = function(utils)
    return utils.root_has_file({ ".prettierrc" })
end

local is_deno_project = function(utils)
    return utils.root_has_file({ "deno.json" })
end

local should_format_with_prettier = function(utils)
    return not is_eslint_project(utils) and is_prettier_project(utils)
end

null_ls.setup({
    diagnostics_format = "[#{c}] #{m} (#{s})",
    debug = false,
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
        -- formatting sources
        formatting.prettier_d_slim.with({
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
