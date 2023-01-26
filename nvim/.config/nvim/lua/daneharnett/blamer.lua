local M = {}

function M.init()
    local utils = require("daneharnett.utils")
    utils.keymap("n", "<leader>bt", "<cmd>BlamerToggle<cr>")
end

return M
