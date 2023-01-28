local M = {}

function M.init()
    M.attach_keymaps()

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
        if tmp_file then
            tmp_file:write(prompt)
            tmp_file:flush()
        end
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

                save_lgwg_prompt(prompt)

                -- apply the search query
                local query = prompt_split[2]

                -- a prompt is "regex" if it begins and ends with `/`
                local is_regex_query = string.sub(query, 1, 1) == "/"
                    and string.sub(query, string.len(query), string.len(query)) == "/"

                if is_regex_query then
                    local query_without_slashes = string.sub(query, 2, string.len(query) - 1)
                    table.insert(args, string.format("--regexp=%s", query_without_slashes))
                else
                    table.insert(args, "--fixed-strings")
                end

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

                if not is_regex_query then
                    table.insert(command, query)
                end

                return command
            end,
            entry_maker = make_entry.gen_from_vimgrep(),
        })

        pickers
            .new({
                file_ignore_patterns = { ".git/" },
            }, {
                debounce = 100,
                default_text = read_saved_lgwg_prompt(),
                prompt_title = "Live grep with globs",
                finder = live_grep_with_globs,
                previewer = conf.grep_previewer({}),
                sorter = require("telescope.sorters").highlighter_only(),
            })
            :find()
    end, {})

    vim.api.nvim_create_user_command("TelescopeCustomLiveGrep", function()
        local custom_live_grep = finders.new_async_job({
            command_generator = function(prompt)
                if not prompt or prompt == "" then
                    return nil
                end

                local query = prompt

                local args = { "rg" }

                -- is "regex" if it begins and ends with `/`
                local is_regex_query = string.sub(query, 1, 1) == "/"
                    and string.sub(query, string.len(query), string.len(query)) == "/"

                if is_regex_query then
                    local query_without_slashes = string.sub(query, 2, string.len(query) - 1)
                    table.insert(args, string.format("--regexp=%s", query_without_slashes))
                else
                    table.insert(args, "--fixed-strings")
                end

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

                if not is_regex_query then
                    table.insert(command, query)
                end

                return command
            end,
            entry_maker = make_entry.gen_from_vimgrep(),
        })

        pickers
            .new({
                file_ignore_patterns = { ".git/" },
            }, {
                debounce = 100,
                prompt_title = "Live grep",
                finder = custom_live_grep,
                previewer = conf.grep_previewer({}),
                sorter = require("telescope.sorters").highlighter_only(),
            })
            :find()
    end, {})
end

M.attach_keymaps = function()
    local utils = require("daneharnett.utils")
    utils.keymap("n", "<C-p>", "<CMD>Telescope find_files<CR>")
    utils.keymap("n", "<LEADER>dl", "<CMD>Telescope diagnostics<CR>")
    utils.keymap("n", "<LEADER>fb", "<CMD>Telescope file_browser<CR>")
    utils.keymap("n", "<LEADER>fg", "<CMD>Telescope git_files<CR>")
    utils.keymap("n", "<LEADER>fh", "<CMD>Telescope help_tags<CR>")
    utils.keymap("n", "<LEADER>fs", "<CMD>Telescope grep_string<CR>")
    utils.keymap("n", "<LEADER>lb", "<CMD>Telescope buffers<CR>")
    utils.keymap("n", "<LEADER>lg", "<CMD>Telescope live_grep<CR>")
    utils.keymap("n", "<LEADER>tr", "<CMD>Telescope resume<CR>")
    utils.keymap("n", "<LEADER>ff", "<CMD>TelescopeLiveGrepWithGlobs<CR>")
end

return M
