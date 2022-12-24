local M = {}

function M.setup()
    require("colorizer").setup({
        typescriptreact = { css = true },
    })
end

return M
