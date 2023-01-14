local M = {}

function M.init()
    local utils = require("daneharnett.utils")
    utils.key_mapper("n", "<leader>tf", ":TestFile<CR>")
end

return M
