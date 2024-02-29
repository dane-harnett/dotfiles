local M = {}

function M.init()
    local autosession_status_ok, autosession = pcall(require, "auto-session")
    if not autosession_status_ok then
        return
    end

    autosession.setup({
        pre_save_cmds = { "tabdo NvimTreeClose" },
    })
end

return M
