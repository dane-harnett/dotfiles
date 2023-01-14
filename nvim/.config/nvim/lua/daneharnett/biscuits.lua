local M = {}

function M.init()
    -- Don't apply this in vscode
    if not vim.g.vscode then
        local biscuits_status_ok, biscuits = pcall(require, "nvim-biscuits")
        if not biscuits_status_ok then
            return
        end
        biscuits.setup({
            cursor_line_only = true,
        })
    end
end

return M
