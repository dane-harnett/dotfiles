local M = {}

function M.init()
    local status_ok, nvim_tree = pcall(require, "nvim-tree")
    if not status_ok then
        return
    end

    nvim_tree.setup({
        diagnostics = {
            enable = true,
        },
        filters = {
            custom = {
                "^\\.git$",
            },
        },
        view = {
            centralize_selection = true,
            side = "right",
        },
        renderer = {
            indent_markers = {
                enable = true,
            },
        },
    })

    local utils = require("daneharnett.utils")
    utils.keymap("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<cr>")
    utils.keymap("n", "<C-8>", "<cmd>NvimTreeResize +5<cr>")
    utils.keymap("n", "<C-9>", "<cmd>NvimTreeResize -5<cr>")
end

return M
