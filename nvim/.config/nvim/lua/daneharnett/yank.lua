local utils = require("daneharnett.utils")

local load_mappings = function()
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
load_mappings()
