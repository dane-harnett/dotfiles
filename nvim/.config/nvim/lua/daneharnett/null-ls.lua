local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
    return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
    debug = false,
    on_attach = function(_, bufnr)
        local group = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format()
            end,
            group = group,
        })
    end,
    sources = {
        diagnostics.eslint_d.with({
          timeout = -1,
        }),
        formatting.eslint_d.with({
            timeout = -1,
        }),
        -- formatting.prettier.with({
        --     prefer_local = "node_modules/.bin",
        --     timeout = -1,
        -- }),
        formatting.stylua,
    },
})
