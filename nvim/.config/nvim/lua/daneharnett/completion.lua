local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end
local lspkind_status_ok, lspkind = pcall(require, "lspkind")
if not cmp_status_ok then
	return
end

cmp.setup({
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
  formatting = {
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
      },
    },
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sorting = {
    comparators = {
      cmp.config.compare.sort_text,
      cmp.config.compare.score,
      cmp.config.compare.order,
      cmp.config.compare.offset,
      cmp.config.compare.kind,
      cmp.config.compare.length,
      cmp.config.compare.exact,
    },
  },
  sources = cmp.config.sources({
    {
      name = 'nvim_lsp',
    },
  }, {
    {
      name = 'buffer',
      keyword_length = 5
    },
  })
})
