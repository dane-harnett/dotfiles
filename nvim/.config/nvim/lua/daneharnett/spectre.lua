local M = {}

function M.init()
    local utils = require("daneharnett.utils")
    local spectre_status_ok, spectre = pcall(require, "spectre")
    if not spectre_status_ok then
        return
    end

    spectre.setup({
        result_padding = "",
        find_engine = {
            -- rg is map with finder_cmd
            ["rg"] = {
                cmd = "rg",
                -- default args
                args = {
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--glob=!.git/",
                },
                options = {
                    ["ignore-case"] = {
                        value = "--ignore-case",
                        icon = "[I]",
                        desc = "ignore case",
                    },
                    ["hidden"] = {
                        value = "--hidden",
                        desc = "hidden file",
                        icon = "[H]",
                    },
                    -- you can put any rg search option you want here it can toggle with
                    -- show_option function
                },
            },
        },
    })

    --utils.key_mapper("n", "<leader>S", '<cmd>lua require("spectre").toggle()<CR>')
    utils.key_mapper("n", "<leader>ss", M.toggle)
    utils.key_mapper("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>')
    utils.key_mapper("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>')
    utils.key_mapper("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>')
end

function M.toggle()
    local spectre_status_ok, spectre = pcall(require, "spectre")
    if not spectre_status_ok then
        return
    end
    local spectre_state_status_ok, spectre_state = pcall(require, "spectre.state")
    if not spectre_state_status_ok then
        return
    end

    M.ensure_nvim_tree_is_closed()

    if spectre_state.is_open then
        spectre.toggle()
    else
        spectre.toggle()
        if spectre_state.query_backup then
            spectre.resume_last_search()
        end
    end
end

function M.ensure_nvim_tree_is_closed()
    local status_ok, nvim_tree_api = pcall(require, "nvim-tree.api")
    if not status_ok then
        return
    end

    nvim_tree_api.tree.close_in_all_tabs()
end

return M
