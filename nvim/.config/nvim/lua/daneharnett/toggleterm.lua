local M = {}

function M.init()
    local status_ok, toggleterm = pcall(require, "toggleterm")
    if not status_ok then
        return
    end

    local utils = require("daneharnett.utils")

    toggleterm.setup({
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "horizontal",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
            border = "curved",
            winblend = 0,
            highlights = {
                border = "Normal",
                background = "Normal",
            },
        },
    })

    local function set_terminal_keymaps()
        utils.current_buffer_keymap("t", "<esc>", [[<C-\><C-n>]])
        utils.current_buffer_keymap("t", "jk", [[<C-\><C-n>]])
        utils.current_buffer_keymap("t", "<C-h>", [[<C-\><C-n><C-W>h]])
        utils.current_buffer_keymap("t", "<C-j>", [[<C-\><C-n><C-W>j]])
        utils.current_buffer_keymap("t", "<C-k>", [[<C-\><C-n><C-W>k]])
        utils.current_buffer_keymap("t", "<C-l>", [[<C-\><C-n><C-W>l]])
    end

    local group = vim.api.nvim_create_augroup("ToggleTerm", { clear = true })
    vim.api.nvim_create_autocmd("TermOpen", {
        callback = set_terminal_keymaps,
        group = group,
        pattern = "term://*",
    })
end

return M
