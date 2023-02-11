local M = {}

function M.init()
    local ts_configs_setup_status_ok = M.setup_treesitter_configs()
    if not ts_configs_setup_status_ok then
        return
    end

    M.setup_treesitter_context()
    M.setup_treesitter_folds()
end

M.setup_treesitter_configs = function()
    local ts_configs_status_ok, ts_configs = pcall(require, "nvim-treesitter.configs")
    if not ts_configs_status_ok then
        return false
    end

    ts_configs.setup({
        ensure_installed = {
            "bash",
            "css",
            "html",
            "java",
            "javascript",
            "json",
            "lua",
            "markdown",
            "markdown_inline",
            "tsx",
            "typescript",
        },
        highlight = {
            enable = true,
        },
        indent = {
            enable = true,
        },
        playground = {
            enable = true,
            updatetime = 25,
        },
    })

    return true
end

M.setup_treesitter_context = function()
    local context_status_ok, tscontext = pcall(require, "treesitter-context")
    if context_status_ok then
        tscontext.setup({})
    end
end

M.setup_treesitter_folds = function()
    local ts_parsers_status_ok, ts_parsers = pcall(require, "nvim-treesitter.parsers")
    if not ts_parsers_status_ok then
        return
    end

    local group = vim.api.nvim_create_augroup("FoldsWithTreesitter", { clear = true })
    local additional_file_types = {
        "typescriptreact",
    }
    local all_file_types = {}

    local parsers = ts_parsers.available_parsers()
    for _, filetype in ipairs(parsers) do
        table.insert(all_file_types, filetype)
    end
    for _, filetype in ipairs(additional_file_types) do
        table.insert(all_file_types, filetype)
    end

    for _, filetype in ipairs(all_file_types) do
        vim.api.nvim_create_autocmd("FileType", {
            pattern = filetype,
            callback = function()
                vim.wo.foldmethod = "expr"
                vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
            end,
            group = group,
        })
    end
end

return M
