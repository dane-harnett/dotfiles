local M = {}

function M.init()
    local status_ok, nvim_tree = pcall(require, "nvim-tree")
    if not status_ok then
        return
    end

    local default_width = 60

    nvim_tree.setup({
        diagnostics = {
            enable = true,
        },
        filters = {
            custom = {
                "^\\.git$",
            },
        },
        git = {
            -- double the default timeout to handle large repos
            -- based on if git integration gets disabled I will progressively
            -- lower/raise this.
            timeout = 800,
        },
        view = {
            centralize_selection = true,
            side = "right",
            width = default_width,
        },
        renderer = {
            indent_markers = {
                enable = true,
            },
        },
    })

    local utils = require("daneharnett.utils")
    utils.keymap("n", "<leader>e", M.focus_or_toggle)
    utils.keymap("n", "<C-6>", "<cmd>NvimTreeResize " .. default_width .. "<cr>")
    utils.keymap("n", "<C-7>", "<cmd>NvimTreeResize 100<cr>")
    utils.keymap("n", "<C-8>", "<cmd>NvimTreeResize +5<cr>")
    utils.keymap("n", "<C-9>", "<cmd>NvimTreeResize -5<cr>")
end

function M.focus_or_toggle()
    local status_ok, nvim_tree_api = pcall(require, "nvim-tree.api")
    if not status_ok then
        return
    end
    local buf = vim.api.nvim_get_current_buf()
    local file_type = vim.api.nvim_get_option_value("filetype", { buf = buf })
    if file_type == "NvimTree" then
        nvim_tree_api.tree.toggle()
    else
        nvim_tree_api.tree.focus({
            find_file = true,
            focus = true,
        })
    end
end

return M
