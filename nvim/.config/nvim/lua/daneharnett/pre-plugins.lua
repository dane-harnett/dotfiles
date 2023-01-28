local M = {}

function M.init()
    -- all of these settings need to be set before the plugins are loaded

    vim.g.mapleader = " "

    -- disable netrw (strongly advised by nvim-tree)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    vim.opt.termguicolors = true
end

return M
