local load_mappings = function()
    vim.keymap.set("n", "<C-p>", "<CMD>Telescope find_files<CR>")
    vim.keymap.set("n", "<LEADER>dl", "<CMD>Telescope diagnostics<CR>")
    vim.keymap.set("n", "<LEADER>fb", "<CMD>Telescope file_browser<CR>")
    vim.keymap.set("n", "<LEADER>fg", "<CMD>Telescope git_files<CR>")
    vim.keymap.set("n", "<LEADER>fh", "<CMD>Telescope help_tags<CR>")
    vim.keymap.set("n", "<LEADER>fs", "<CMD>Telescope grep_string<CR>")
    vim.keymap.set("n", "<LEADER>lb", "<CMD>Telescope buffers<CR>")
    vim.keymap.set("n", "<LEADER>lg", "<CMD>Telescope live_grep<CR>")
    vim.keymap.set("n", "<LEADER>tr", "<CMD>Telescope resume<CR>")
end
load_mappings()

local telescope_actions_set = require("telescope.actions.set")
-- FileType event doesn't fire when opening from telescope
-- https://github.com/nvim-telescope/telescope.nvim/issues/699
-- workaround from:
-- https://github.com/David-Kunz/vim/blob/master/init.lua#L205-L232
local fixfolds = {
    file_ignore_patterns = { ".git/" },
    hidden = true,
    attach_mappings = function(_)
        telescope_actions_set.select:enhance({
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
    "--smart-case",
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
    -- find_command = base_find_command,
})
local oldfiles = fixfolds

local telescope = require("telescope")
local telescope_actions = require("telescope.actions")
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
        mappings = {
            i = {
                ["<C-D>"] = telescope_actions.cycle_history_next,
                ["<C-U>"] = telescope_actions.cycle_history_prev,
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
telescope.load_extension("harpoon")

vim.api.nvim_create_user_command("TelescopeFindFilesIncludingHidden", function()
    require("telescope.builtin").find_files(find_files_including_hidden)
end, {})

local TMP_GLOB_PATTERN_FILENAME = "/tmp/nvim_daneharnett_find_panel_include_globs"

local function read_default_glob_pattern()
    local tmp_glob_pattern_file = nil

    local read_tmp_glob_pattern_file = function()
        tmp_glob_pattern_file = io.input(TMP_GLOB_PATTERN_FILENAME)
    end

    if pcall(read_tmp_glob_pattern_file) then
        return tmp_glob_pattern_file:read()
    else
        return ""
    end
end

local function save_default_glob_pattern(glob_pattern)
    local tmp_glob_pattern_file = io.output(TMP_GLOB_PATTERN_FILENAME)
    tmp_glob_pattern_file:write(glob_pattern)
    tmp_glob_pattern_file:flush()
end

-- My custom find panel implementation
-- TODO: have a keymap in telescope that closes the picker and re-prompts
-- TODO?: implement with a better ui
vim.api.nvim_create_user_command("TelescopeFindPanel", function()
    local default_glob_pattern = read_default_glob_pattern()

    local glob_pattern = {}

    vim.ui.input({
        default = default_glob_pattern,
        prompt = "Glob pattern: ",
    }, function(input_glob_pattern)
        if input_glob_pattern == nil then
            -- User aborted the input dialog.
            input_glob_pattern = "*"
        end

        save_default_glob_pattern(input_glob_pattern)

        local split_patterns = vim.split(input_glob_pattern, ",")

        for _, pattern in pairs(split_patterns) do
            pattern = string.gsub(pattern, "^%s*(.-)%s*$", "%1")
            if pattern ~= "" then
                -- prepend and append `*` to the pattern
                -- in order to match anywhere within the file path.
                if string.sub(pattern, 0) ~= "*" then
                    pattern = string.format("*%s", pattern)
                end
                if string.sub(pattern, -1) ~= "*" then
                    pattern = string.format("%s*", pattern)
                end
                table.insert(glob_pattern, pattern)
            end
        end

        local find_panel = vim.tbl_extend("force", fixfolds, {
            glob_pattern = glob_pattern,
        })

        require("telescope.builtin").live_grep(find_panel)
    end)
end, {})

local conf = require("telescope.config").values
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local pickers = require("telescope.pickers")

local TMP_LGWG_PROMPT_FILENAME = "/tmp/nvim_daneharnett_live_grep_with_globs_prompt"

local function read_saved_lgwg_prompt()
    local tmp_file = nil

    local read_file = function()
        tmp_file = io.input(TMP_LGWG_PROMPT_FILENAME)
    end

    if pcall(read_file) then
        return tmp_file:read()
    else
        return ""
    end
end

local function save_lgwg_prompt(prompt)
    local tmp_file = io.output(TMP_LGWG_PROMPT_FILENAME)
    tmp_file:write(prompt)
    tmp_file:flush()
end

vim.api.nvim_create_user_command("TelescopeLiveGrepWithGlobs", function()
    local live_grep_with_globs = finders.new_async_job({
        command_generator = function(prompt)
            if not prompt or prompt == "" then
                return nil
            end

            local prompt_split = vim.split(prompt, "  ")

            if not prompt_split[1] or not prompt_split[2] or prompt_split[2] == "" then
                return nil
            end

            local args = { "rg" }

            -- apply the globs
            local pattern = prompt_split[1]
            local split_pattern = vim.split(pattern, ",")

            for _, patt in pairs(split_pattern) do
                patt = string.gsub(patt, "^%s*(.-)%s*$", "%1")
                if patt ~= "" then
                    table.insert(args, string.format("--glob=%s", patt))
                end
            end

            table.insert(args, "--glob=!.git/")

            save_lgwg_prompt(prompt)

            -- apply the search query
            table.insert(args, string.format("--regexp=%s", prompt_split[2]))

            local command = vim.tbl_flatten({
                args,
                {
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--hidden",
                },
            })

            print(vim.inspect(command))

            return command
        end,
        entry_maker = make_entry.gen_from_vimgrep(),
    })

    pickers
        .new({}, {
            debounce = 100,
            default_text = read_saved_lgwg_prompt(),
            prompt_title = "Live grep with globs",
            finder = live_grep_with_globs,
            previewer = conf.grep_previewer({}),
            sorter = require("telescope.sorters").highlighter_only(),
        })
        :find()
end, {})
