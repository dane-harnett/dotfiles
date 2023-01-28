local M = {}

function M.init()
    local utils = require("daneharnett.utils")
    -- In normal mode...
    -- Move current line down one line
    utils.keymap("n", "<A-j>", "<Esc>:m .+1<CR><Esc>")
    -- Move current line up one line
    utils.keymap("n", "<A-k>", "<Esc>:m .-2<CR><Esc>")

    -- In visual/visual-line mode...
    -- Stay in visual/visual-line mode after deindenting
    utils.keymap("v", "<", "<gv")
    -- Stay in visual/visual-line mode after indenting
    utils.keymap("v", ">", ">gv")

    -- Move selected line(s) down one line
    utils.keymap("v", "<A-j>", ":m .+1<CR>==")
    -- Move selected line(s) up one line
    utils.keymap("v", "<A-k>", ":m .-2<CR>==")
    -- what is this?
    utils.keymap("v", "p", '"_dP')

    -- In visual-block mode...
    -- Move selected block down one line
    utils.keymap("x", "J", ":move '>+1<CR>gv-gv")
    utils.keymap("x", "<A-j>", ":move '>+1<CR>gv-gv")
    -- Move selected block up one line
    utils.keymap("x", "K", ":move '<-2<CR>gv-gv")
    utils.keymap("x", "<A-k>", ":move '<-2<CR>gv-gv")
end

return M
