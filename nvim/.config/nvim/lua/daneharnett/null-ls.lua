local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      local group = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = vim.api.nvim_get_current_buf(),
        callback = vim.lsp.buf.formatting_sync,
        group = group
      })
    end
  end,
  sources = {
    diagnostics.eslint_d,
    formatting.eslint_d,
    formatting.prettier.with({
      prefer_local = "node_modules/.bin",
      timeout = 10000,
    }),
  },
})
