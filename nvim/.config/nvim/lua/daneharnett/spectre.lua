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

    utils.keymap("n", "<leader>ss", M.toggle, "Toggle [s]pectre [s]earch")
    utils.keymap(
        "n",
        "<leader>sw",
        '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
        "[S]pectre search [w]ord"
    )
    utils.keymap(
        "v",
        "<leader>sw",
        '<esc><cmd>lua require("spectre").open_visual()<CR>',
        "[S]pectre search [w]ord (visual)"
    )
    utils.keymap(
        "n",
        "<leader>scf",
        '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
        "[S]pectre [c]urrent [f]ile"
    )
end

function is_empty(s)
    return s == nil or s == ""
end

function is_query_empty(query)
    if query == nil then
        return true
    end
    return is_empty(query.search_query) and is_empty(query.replace_query) and is_empty(query.path)
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

    spectre.toggle()
    if not is_query_empty(spectre_state.query_backup) then
        spectre.resume_last_search()
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
