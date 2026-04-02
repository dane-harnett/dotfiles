local M = {}

function M.init()
    require("luasnip.loaders.from_vscode").lazy_load()

    require("blink.cmp").setup({
        keymap = {
            preset = "default",
        },
        appearance = {
            nerd_font_variant = "mono",
        },
        completion = {
            documentation = { auto_show = false, auto_show_delay_ms = 500 },
        },
        sources = {
            default = { "lsp", "path", "snippets", "lazydev" },
            providers = {
                lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
            },
        },
        snippets = { preset = "luasnip" },
        fuzzy = { implementation = "prefer_rust" },
        signature = { enabled = true },
    })
end

return M
