local M = {}

function M.init()
    local telescope = require("telescope")

    telescope.setup({
        defaults = M.get_defaults(),
        extensions = M.get_extensions(),
        pickers = M.get_pickers(),
    })

    M.load_extensions()
    M.create_user_commands()
    M.attach_keymaps()
end

M.get_defaults = function()
    local actions = require("telescope.actions")
    local previewers = require("telescope.previewers")
    local sorters = require("telescope.sorters")

    return {
        file_sorter = sorters.get_fzy_sorter,
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
                ["<C-D>"] = actions.cycle_history_next,
                ["<C-U>"] = actions.cycle_history_prev,
            },
        },
        file_previewer = previewers.vim_buffer_cat.new,
        grep_previewer = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,
    }
end

M.get_extensions = function()
    local themes = require("telescope.themes")
    return {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
        ["ui-select"] = {
            themes.get_dropdown(),
        },
    }
end

M.get_pickers = function()
    return {
        buffers = { preview = true },
        find_files = M.get_find_files(),
        git_files = {},
        grep_string = { preview = true },
        live_grep = {
            additional_args = function()
                return { "--hidden" }
            end,
        },
        oldfiles = {},
    }
end

M.load_extensions = function()
    local telescope = require("telescope")
    pcall(telescope.load_extension, "fzf")
    pcall(telescope.load_extension, "harpoon")
    pcall(telescope.load_extension, "ui-select")
end

M.create_user_commands = function()
    vim.api.nvim_create_user_command("TelescopeFindFilesIncludingHidden", M.find_files_including_hidden, {})
    vim.api.nvim_create_user_command("TelescopeCustomLiveGrep", M.live_grep_with_globs, {})
    vim.api.nvim_create_user_command("TelescopeLiveGrepWithGlobs", M.live_grep_with_globs, {})
    vim.api.nvim_create_user_command("TelescopeInsertPathToDirectory", M.insert_path_to_directory, {})
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
    utils.keymap("n", "<LEADER>fdp", "<CMD>TelescopeInsertPathToDirectory<CR>")
end

M.live_grep_with_globs = function()
    local conf = require("telescope.config").values
    local finders = require("telescope.finders")
    local make_entry = require("telescope.make_entry")
    local pickers = require("telescope.pickers")

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
            prompt_title = "Live grep with globs",
            finder = live_grep_with_globs,
            previewer = conf.grep_previewer({}),
            sorter = require("telescope.sorters").highlighter_only(),
        })
        :find()
end

M.custom_live_grep = function()
    local conf = require("telescope.config").values
    local finders = require("telescope.finders")
    local make_entry = require("telescope.make_entry")
    local pickers = require("telescope.pickers")

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
end

M.insert_path_to_directory = function()
    local opts = {
        attach_mappings = M.insert_selected_entry,
        find_command = {
            "fd",
            "--type=d",
            "--hidden",
            "--exclude=.git",
            "--exclude=node_modules",
        },
    }
    require("telescope.builtin").find_files(opts)
end

M.insert_selected_entry = function(prompt_bufnr)
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        vim.api.nvim_put({ selection[1] }, "c", true, true)
    end)
    return true
end

M.get_base_find_command = function()
    return {
        "rg",
        "--files",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
    }
end

M.get_base_find_layout_config = function()
    return {
        horizontal = {
            preview_width = 0,
        },
    }
end

M.get_find_files = function()
    return {
        attach_mappings = function(_, map)
            -- press ctrl+h to toggle hidden files
            map("i", "<C-h>", function(_prompt_bufnr)
                local state = require("telescope.actions.state")
                M.find_files_including_hidden(state.get_current_line())
            end)
            return true
        end,
        find_command = M.get_base_find_command(),
        layout_config = M.get_base_find_layout_config(),
    }
end

M.find_files_including_hidden = function(default_text_arg)
    local default_text = default_text_arg or ""
    local base_find_command = M.get_base_find_command()
    local find_command_with_hidden = vim.list_extend({}, base_find_command)
    vim.list_extend(find_command_with_hidden, { "--hidden", "--glob=!.git/" })
    local find_files_including_hidden = {
        attach_mappings = function(_, map)
            -- press ctrl+h to toggle hidden files
            map("i", "<C-h>", function(_prompt_bufnr)
                local state = require("telescope.actions.state")
                require("telescope.builtin").find_files({
                    default_text = state.get_current_line(),
                })
            end)
            return true
        end,
        find_command = find_command_with_hidden,
        layout_config = M.get_base_find_layout_config(),
        prompt_title = "Find Files (including hidden)",
        default_text = default_text,
    }
    require("telescope.builtin").find_files(find_files_including_hidden)
end

return M
