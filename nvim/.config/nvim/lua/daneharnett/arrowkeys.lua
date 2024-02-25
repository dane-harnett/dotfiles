local M = {}

function M.init()
    local utils = require("daneharnett.utils")

    -- disable the arrow keys
    utils.keymap("", "<up>", "<nop>")
    utils.keymap("", "<down>", "<nop>")
    utils.keymap("", "<left>", "<nop>")
    utils.keymap("", "<right>", "<nop>")
end

return M
