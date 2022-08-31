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
        diagnostics.eslint_d.with({
            -- We only want this source to apply when the project uses eslint.
            condition = is_eslint_project,
            timeout = -1,
        }),
        formatting.eslint_d.with({
            -- We only want this source to apply when the project uses eslint.
            condition = is_eslint_project,
            -- This filter function should prevent eslint_d from applying any
            -- formats that have been suggested by eslint-plugin-prettier, they
            -- will be applied by the prettier formatter below.
            filter = function(diagnostic)
                return diagnostic.code ~= "prettier/prettier"
            end,
            timeout = -1,
        }),
        formatting.prettier.with({
            -- We only want this source to apply when the project uses prettier.
            condition = is_prettier_project,
            prefer_local = "node_modules/.bin",
            timeout = -1,
        }),
        formatting.stylua,
    },
})
