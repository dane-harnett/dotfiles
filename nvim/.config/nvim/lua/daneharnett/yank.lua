local M = {}

function M.init()
    local utils = require("daneharnett.utils")

    -- Make it so that yanking also places the selection into the system clipboard --
    vim.opt.clipboard:append("unnamedplus")

    -- When in visual mode, after yanking keep the cursor in the last selected
    -- position.
    utils.keymap("v", "y", "ygv<Esc>")

    -- Exclude these yank keymaps from vscode
    -- Yank into system clipboard
    utils.keymap("v", "<leader>y", '"+ygv<esc>')
    utils.keymap("n", "<leader>y", '"+y')
end

return M
