local M = {}

function M.init()
    local utils = require("daneharnett.utils")

    if not vim.g.vscode then
        -- Make it so that yanking also places the selection into the system clipboard --
        vim.opt.clipboard:append("unnamedplus")
    end

    -- When in visual mode, after yanking keep the cursor in the last selected
    -- position.
    utils.keymap("v", "y", "ygv<Esc>")

    -- Exclude these yank keymaps from vscode
    if not vim.g.vscode then
        -- Yank into system clipboard
        utils.keymap("v", "<leader>y", '"+ygv<esc>')
        utils.keymap("n", "<leader>y", '"+y')
    end
end

return M
