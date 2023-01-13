local M = {}

function M.init()
    local status_ok, lspsaga = pcall(require, "lspsaga")
    if not status_ok then
        return
    end

    lspsaga.setup({})
end

return M
