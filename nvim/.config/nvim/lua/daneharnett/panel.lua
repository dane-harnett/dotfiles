-- Treat plugins that open in a split on the right (nvim-tree, spectre) like
-- a side-panel. This module adds a keymap to close all "panels".
-- See nvim-tree and spectre files for more of this implementation like
-- switching between plugins, opening and focusing.
local M = {}

function M.init()
    local utils = require("daneharnett.utils")

    utils.keymap("n", "<leader>pc", M.close_panel, "[P]anel [c]lose")
end

function M.close_panel()
    M.close_nvim_tree()
    M.close_spectre()
end

function M.close_nvim_tree()
    local status_ok, nvim_tree_api = pcall(require, "nvim-tree.api")
    if not status_ok then
        return
    end
    nvim_tree_api.tree.close_in_all_tabs()
end

function M.close_spectre()
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

return M
