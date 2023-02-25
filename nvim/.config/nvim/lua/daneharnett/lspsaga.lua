local M = {}

function M.init()
    local status_ok, lspsaga = pcall(require, "lspsaga")
    if not status_ok then
        return
    end

    lspsaga.setup({})
end

function M.attach_keymaps_to_buffer(bufnr)
    local utils = require("daneharnett.utils")

    -- lsp provider to find the cursor word definition and reference
    utils.buffer_keymap(bufnr, "n", "gh", "<cmd>Lspsaga lsp_finder<CR>")

    -- code action
    utils.buffer_keymap(bufnr, { "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")

    -- show hover doc
    utils.buffer_keymap(bufnr, "n", "K", "<cmd>Lspsaga hover_doc<CR>")

    -- Call hierarchy
    utils.buffer_keymap(bufnr, "n", "<leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
    utils.buffer_keymap(bufnr, "n", "<leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

    -- scroll down hover doc or scroll in definition preview
    utils.buffer_keymap(bufnr, "n", "<C-f>", ':lua require"lspsaga.action".smart_scroll_with_saga(1)<CR>')

    -- scroll up hover doc
    utils.buffer_keymap(bufnr, "n", "<C-b>", ':lua require"lspsaga.action".smart_scroll_with_saga(-1)<CR>')

    -- show signature help
    -- utils.("n", "gs", ':lua require"lspsaga.signaturehelp".signature_help()<CR>')

    -- rename
    utils.buffer_keymap(bufnr, "n", "gr", "<cmd>Lspsaga rename<CR>")

    -- peek definition
    utils.buffer_keymap(bufnr, "n", "gp", "<cmd>Lspsaga peek_definition<CR>")

    -- go to definition
    utils.buffer_keymap(bufnr, "n", "gd", "<cmd>Lspsaga goto_definition<CR>")

    -- show line diagnostics
    utils.buffer_keymap(bufnr, "n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")

    -- show cursor diagnostics
    utils.buffer_keymap(bufnr, "n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

    -- Show buffer diagnostics
    utils.buffer_keymap(bufnr, "n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")

    -- jump to diagnostic
    utils.buffer_keymap(bufnr, "n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
    utils.buffer_keymap(bufnr, "n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

    -- Diagnostic jump with filter like Only jump to error
    utils.buffer_keymap(bufnr, "n", "[E", function()
        require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end)
    utils.buffer_keymap(bufnr, "n", "]E", function()
        require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
    end)

    -- floating terminal
    utils.buffer_keymap(bufnr, { "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")
end

return M
