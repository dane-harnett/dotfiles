local M = {}

function M.init()
    local biscuits_status_ok, biscuits = pcall(require, "nvim-biscuits")
    if not biscuits_status_ok then
        return
    end
    biscuits.setup({
        cursor_line_only = true,
        on_events = {
            "CursorHold",
            "CursorHoldI",
            "InsertLeave",
        },
    })
end

return M
