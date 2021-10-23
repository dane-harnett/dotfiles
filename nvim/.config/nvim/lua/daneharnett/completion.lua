local cmp = require'cmp'
local lspkind = require'lspkind'

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
  sources = cmp.config.sources({
    {
      name = 'nvim_lsp',
      max_item_count = 10
    },
  }, {
    {
      name = 'buffer',
      keyword_length = 5
    },
  })
})
