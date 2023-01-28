local utils = require("daneharnett.utils")
local load_mappings = function()
    -- Normal --
    -- Better window navigation
    utils.keymap("n", "<C-h>", "<C-w>h")
    utils.keymap("n", "<C-j>", "<C-w>j")
    utils.keymap("n", "<C-k>", "<C-w>k")
    utils.keymap("n", "<C-l>", "<C-w>l")

    -- Resize with arrows
    utils.keymap("n", "<C-Up>", ":resize -2<CR>")
    utils.keymap("n", "<C-Down>", ":resize +2<CR>")
    utils.keymap("n", "<C-Left>", ":vertical resize -2<CR>")
    utils.keymap("n", "<C-Right>", ":vertical resize +2<CR>")

    -- Navigate buffers
    utils.keymap("n", "<S-l>", ":bnext<CR>")
    utils.keymap("n", "<S-h>", ":bprevious<CR>")
end
load_mappings()
