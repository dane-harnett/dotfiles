local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end
local lspkind_status_ok, lspkind = pcall(require, "lspkind")
if not lspkind_status_ok then
    return
end

cmp.setup({
    experimental = {
        native_menu = false,
        ghost_text = true,
    },
    formatting = {
        format = lspkind.cmp_format({
            with_text = true,
            menu = {
                buffer = "[buf]",
                nvim_lsp = "[LSP]",
            },
        }),
    },
    mapping = {
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- yes, but error thrown
        ["<C-Space>"] = cmp.mapping.complete(), -- no
        ["<C-d>"] = cmp.mapping.scroll_docs(-4), -- ?
        ["<C-e>"] = cmp.mapping.close(), -- yes
        ["<C-f>"] = cmp.mapping.scroll_docs(4), -- ?
        ["<C-n>"] = function(fallback) -- yes
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ["<C-p>"] = function(fallback) -- yes
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end,
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
            name = "nvim_lsp",
        },
    }, {
        {
            name = "buffer",
            keyword_length = 5,
        },
    }),
})
