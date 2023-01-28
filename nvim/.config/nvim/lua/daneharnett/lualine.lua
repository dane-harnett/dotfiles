local M = {}

function M.init()
    local lualine_status_ok, lualine = pcall(require, "lualine")
    if not lualine_status_ok then
        return
    end

    lualine.setup({
        options = {
            disabled_filetypes = {
                "NvimTree",
            },
        },
    })
end

return M
