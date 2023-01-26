local M = {}

function M.init()
    require("lualine").setup({
        options = {
            disabled_filetypes = {
                "NvimTree",
            },
        },
    })
end

return M
