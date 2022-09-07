local load_mappings = function()
    vim.keymap.set("n", "<C-p>", "<CMD>Telescope find_files<CR>")
    vim.keymap.set("n", "<LEADER>dl", "<CMD>Telescope diagnostics<CR>")
    vim.keymap.set("n", "<LEADER>fb", "<CMD>Telescope file_browser<CR>")
    vim.keymap.set("n", "<LEADER>fg", "<CMD>Telescope git_files<CR>")
    vim.keymap.set("n", "<LEADER>fh", "<CMD>Telescope help_tags<CR>")
    vim.keymap.set("n", "<LEADER>fs", "<CMD>Telescope grep_string<CR>")
    vim.keymap.set("n", "<LEADER>lb", "<CMD>Telescope buffers<CR>")
    vim.keymap.set("n", "<LEADER>lg", "<CMD>Telescope live_grep<CR>")
end
load_mappings()

local telescope_actions = require("telescope.actions.set")
-- FileType event doesn't fire when opening from telescope
-- https://github.com/nvim-telescope/telescope.nvim/issues/699
-- workaround from:
-- https://github.com/David-Kunz/vim/blob/master/init.lua#L205-L232
local fixfolds = {
    file_ignore_patterns = { ".git/" },
    hidden = true,
    attach_mappings = function(_)
        telescope_actions.select:enhance({
            post = function()
                vim.cmd(":normal! zx")
            end,
        })
        return true
    end,
}

local buffers = vim.tbl_extend("force", fixfolds, { preview = true })
local base_find_command = {
    "rg",
    "--files",
    "--color=never",
    "--no-heading",
    "--with-filename",
    "--line-number",
    "--column",
    "--smart-case"
}
local find_layout_config = {
    horizontal = {
        preview_width = 0,
    },
}
local find_files = vim.tbl_extend("force", fixfolds, {
    find_command = base_find_command,
    layout_config = find_layout_config,
})
local find_files_including_hidden = vim.tbl_extend("force", fixfolds, {
    find_command = vim.tbl_extend("force", base_find_command, { "--hidden" }),
    layout_config = find_layout_config,
})
local git_files = fixfolds
local grep_string = vim.tbl_extend("force", fixfolds, { preview = true })
local live_grep = vim.tbl_extend("force", fixfolds, {
    additional_args = function()
        return { "--hidden" }
    end,
})
local oldfiles = fixfolds

local telescope = require("telescope")
telescope.setup({
    defaults = {
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        path_display = {
            truncate = true,
        },
        prompt_prefix = " >",
        color_devicons = true,
        layout_config = {
            horizontal = {
                preview_width = 40,
                width = 0.9,
            },
        },
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
    },
    pickers = {
        buffers = buffers,
        find_files = find_files,
        git_files = git_files,
        grep_string = grep_string,
        live_grep = live_grep,
        oldfiles = oldfiles,
    },
})
telescope.load_extension("fzf")

vim.api.nvim_create_user_command("TelescopeFindFilesIncludingHidden", function()
    require("telescope.builtin").find_files(find_files_including_hidden)
end, {})
