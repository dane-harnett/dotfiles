local M = {}

function M.init()
    require("trouble").setup()
end

function M.attach_keymaps_to_buffer(bufnr)
    local utils = require("daneharnett.utils")
    utils.buffer_keymap(bufnr, "n", "<leader>gr", "<cmd>Trouble lsp_references<cr>")
end

return M
