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
    utils.buffer_keymap(bufnr, "n", "gh", "<cmd>Lspsaga finder<CR>")

    -- code action
    utils.buffer_keymap(bufnr, { "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")

    -- show hover doc
    utils.buffer_keymap(bufnr, "n", "K", "<cmd>Lspsaga hover_doc<CR>")

    -- Call hierarchy
    utils.buffer_keymap(bufnr, "n", "<leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
    utils.buffer_keymap(bufnr, "n", "<leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

    -- rename
    utils.buffer_keymap(bufnr, "n", "gr", function()
        vim.lsp.buf.rename()
    end)

    -- peek definition
    utils.buffer_keymap(bufnr, "n", "gp", "<cmd>Lspsaga peek_definition<CR>")

    -- go to definition
    utils.buffer_keymap(bufnr, "n", "gd", function()
        vim.lsp.buf.definition()
    end)

    -- show line diagnostics
    utils.buffer_keymap(bufnr, "n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")

    -- show cursor diagnostics
    utils.buffer_keymap(bufnr, "n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

    -- Show buffer diagnostics
    utils.buffer_keymap(bufnr, "n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")

    local on_jump_open_float = function()
        vim.diagnostic.open_float()
    end

    -- jump to diagnostic
    utils.buffer_keymap(bufnr, "n", "[e", function()
        vim.diagnostic.jump({
            count = -1,
            on_jump = on_jump_open_float,
        })
    end)
    utils.buffer_keymap(bufnr, "n", "]e", function()
        vim.diagnostic.jump({
            count = 1,
            on_jump = on_jump_open_float,
        })
    end)
    -- Diagnostic jump with filter like Only jump to error
    utils.buffer_keymap(bufnr, "n", "[E", function()
        vim.diagnostic.jump({
            count = -1,
            severity = vim.diagnostic.severity.ERROR,
            on_jump = on_jump_open_float,
        })
    end)
    utils.buffer_keymap(bufnr, "n", "]E", function()
        vim.diagnostic.jump({
            count = 1,
            severity = vim.diagnostic.severity.ERROR,
            on_jump = on_jump_open_float,
        })
    end)
end

function M.autocmd()
    vim.api.nvim_create_autocmd("LspAttach", {
        desc = "Load Lspsaga and dependencies when LSP attaches",
        once = true,
        callback = function()
            M.init()
        end,
    })
end

return M
