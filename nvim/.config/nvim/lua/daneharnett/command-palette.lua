local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local commands = {
    {
        title = "Find in project",
        command = "Telescope live_grep",
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
        title = "Diagnostics",
        command = "Telescope diagnostics",
    },
    {
        title = "Sync plugins (packer sync)",
        command = "PackerSync",
    },
}

local function open_command_palette()
    local opts = {}
    pickers.new(opts, {
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
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                vim.schedule(function()
                    vim.cmd(selection.value.command)
                end)
            end)
            return true
        end,
    }):find()
end

local utils = require("daneharnett.utils")
utils.keymap("n", "<leader>cp", open_command_palette)
