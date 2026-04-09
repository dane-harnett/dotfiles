local M = {}

function M.init()
    require("mini.files").setup()
    local utils = require("daneharnett.utils")
    utils.keymap("n", "<leader>me", function()
        MiniFiles.open()
    end)
    utils.keymap("n", "<leader>mc", function()
        MiniFiles.open(vim.api.nvim_buf_get_name(0))
    end)
end

return M
