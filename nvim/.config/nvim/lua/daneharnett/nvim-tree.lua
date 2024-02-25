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
        on_attach = M.on_attach,
        renderer = {
            indent_markers = {
                enable = true,
            },
        },
        view = {
            centralize_selection = true,
            side = "right",
            width = default_width,
        },
    })

    local utils = require("daneharnett.utils")
    utils.keymap("n", "<leader>e", M.focus_or_toggle)
    utils.keymap("n", "<C-6>", "<cmd>NvimTreeResize " .. default_width .. "<cr>")
    utils.keymap("n", "<C-7>", "<cmd>NvimTreeResize 100<cr>")
    utils.keymap("n", "<C-8>", "<cmd>NvimTreeResize +5<cr>")
    utils.keymap("n", "<C-9>", "<cmd>NvimTreeResize -5<cr>")
end

function M.on_attach(bufnr)
    local status_ok, nvim_tree_api = pcall(require, "nvim-tree.api")
    if not status_ok then
        return
    end
    nvim_tree_api.config.mappings.default_on_attach(bufnr)

    -- the following keymaps should only be attached to buffers of
    -- `NvimTree` filetype.
    local file_type = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
    if not file_type == "NvimTree" then
        return
    end
    local utils = require("daneharnett.utils")
    utils.keymap("n", "<leader>sf", M.spectre_find_in_folder)
end

function M.focus_or_toggle()
    local status_ok, nvim_tree_api = pcall(require, "nvim-tree.api")
    if not status_ok then
        return
    end

    M.ensure_spectre_is_closed()

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

function M.ensure_spectre_is_closed()
    local spectre_status_ok, spectre = pcall(require, "spectre")
    if not spectre_status_ok then
        return
    end
    local spectre_state_status_ok, spectre_state = pcall(require, "spectre.state")
    if not spectre_state_status_ok then
        return
    end

    if spectre_state.is_open then
        spectre.toggle()
    end
end

function M.spectre_find_in_folder()
    local status_ok, nvim_tree_api = pcall(require, "nvim-tree.api")
    if not status_ok then
        return
    end
    local spectre_status_ok, spectre = pcall(require, "spectre")
    if not spectre_status_ok then
        return
    end
    local plenary_status_ok, plenary = pcall(require, "plenary")
    if not plenary_status_ok then
        return
    end

    local node = nvim_tree_api.tree.get_node_under_cursor()
    if node.type == "directory" then
        node = node
    else
        node = node.parent
    end

    local relative_path = plenary.path:new(node.absolute_path):make_relative()
    local path = relative_path .. "/**"

    nvim_tree_api.tree.toggle()

    spectre.toggle({
        path = path,
    })
end

return M
