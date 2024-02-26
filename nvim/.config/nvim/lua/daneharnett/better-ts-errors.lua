local M = {}

function M.init()
    local bte_status_ok, bte = pcall(require, "better-ts-errors")
    if not bte_status_ok then
        return
    end

    bte.setup()

    local utils = require("daneharnett.utils")
    utils.keymap("n", "]a", M.next)
    utils.keymap("n", "[a", M.previous)
end

function M.next()
    local bte_status_ok, bte = pcall(require, "better-ts-errors")
    if not bte_status_ok then
        return
    end

    bte.disable()
    local target = vim.diagnostic.get_next()
    if not target then
        return
    end
    M.focus_target(target)
    bte.enable()
end

function M.previous()
    local bte_status_ok, bte = pcall(require, "better-ts-errors")
    if not bte_status_ok then
        return
    end

    bte.disable()
    local target = vim.diagnostic.get_prev()
    if not target then
        return
    end
    M.focus_target(target)
    bte.enable()
end

function M.focus_target(target)
    local winid = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_cursor(winid, { target.lnum + 1, (target.col or 1) })
end

return M
