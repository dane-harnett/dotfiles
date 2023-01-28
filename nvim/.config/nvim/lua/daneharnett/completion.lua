local M = {}

function M.init()
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
        mapping = cmp.mapping.preset.insert({
            -- scroll up the docs window
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            -- scroll down the docs window
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            -- open completion popup when in insert mode and its not open
            ["<C-Space>"] = cmp.mapping.complete(),
            -- close completion popup with no suggestion
            ["<C-e>"] = cmp.mapping.abort(),
            -- complete the currently selected suggestion
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
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
            { name = "nvim_lsp" },
            { name = "luasnip" },
        }, {
            {
                name = "buffer",
                keyword_length = 5,
            },
        }),
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
    })
end

return M
