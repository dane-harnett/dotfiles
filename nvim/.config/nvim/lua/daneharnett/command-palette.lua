local M = {}

function M.init()
    -- Exclude this from vscode
    if vim.g.vscode then
        return
    end

    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    local commands = {
        {
            title = "Find in project",
            command = "TelescopeCustomLiveGrep",
        },
        {
            title = "Find files including hidden",
            command = "TelescopeFindFilesIncludingHidden",
        },
        {
            title = "Live grep with globs",
            command = "TelescopeLiveGrepWithGlobs",
        },
        {
            title = "Lsp references",
            command = "Telescope lsp_references",
        },
        {
            title = "Toggle terminal",
            command = "ToggleTerm",
        },
        {
            title = "Git changed files",
            command = "Telescope git_status",
        },
        {
            title = "Git commit history",
            command = "Telescope git_commits",
        },
        {
            title = "List diagnostics for workspace",
            command = "Telescope diagnostics",
        },
        {
            title = "List diagnostics for current file",
            command = "Telescope diagnostics bufnr=0",
        },
        {
            title = "Harpoon: mark add file",
            command = "lua require('harpoon.mark').add_file()",
        },
        {
            title = "Harpoon: open marks in telescope",
            command = "Telescope harpoon marks",
        },
        {
            title = "Blamer: toggle",
            command = "BlamerToggle",
        },
        {
            title = "Resume last cached telescope picker",
            command = "Telescope resume",
        },
        {
            title = "LSP: rename",
            command = vim.lsp.buf.rename,
        },
    }

    local function open_command_palette()
        local opts = {}
        pickers
            .new(opts, {
                -- This option ensures that the command palette is not cahhed
                -- therefore ensuring that it does not get resumed when triggering
                -- Telescope resume, meaning I can trigger resume from the command
                -- palette itself.
                cache_picker = false,
                prompt_title = "Command palette",
                finder = finders.new_table({
                    results = commands,
                    entry_maker = function(entry)
                        return {
                            value = entry,
                            display = entry.title,
                            ordinal = entry.title,
                        }
                    end,
                }),
                sorter = conf.generic_sorter(opts),
                attach_mappings = function(prompt_bufnr)
                    actions.select_default:replace(function()
                        actions.close(prompt_bufnr)
                        local selection = action_state.get_selected_entry()
                        vim.schedule(function()
                            if type(selection.value.command) == "function" then
                                selection.value.command()
                            else
                                vim.cmd(selection.value.command)
                            end
                        end)
                    end)
                    return true
                end,
            })
            :find()
    end

    local utils = require("daneharnett.utils")
    utils.keymap("n", "<leader>cp", open_command_palette)
end

return M
