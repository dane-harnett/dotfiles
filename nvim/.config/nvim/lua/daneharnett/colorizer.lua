local M = {}

function M.init()
    require("colorizer").setup({
        typescriptreact = { css = true },
    })
end

return M
