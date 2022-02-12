local status_ok, null_ls = pcall(require, "null-ls")
if not ls_status_ok then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {
		formatting.prettier,
    -- formatting.eslint_d,
    -- formatting.eslint,
    diagnostics.eslint_d,
    diagnostics.eslint,
	},
})


vim.cmd[[autocmd BufWritePre *js,*ts,*jsx,*tsx,*.graphql,*.json,*.md,*.mdx,*.svelte :lua vim.lsp.buf.formatting_sync()]]
