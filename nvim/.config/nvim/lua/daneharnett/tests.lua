local M = {}

function M.init()
    local utils = require("daneharnett.utils")
    utils.keymap("n", "<leader>tf", ":TestFile<CR>", "[T]est [f]ile")
end

return M
