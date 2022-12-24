local M = {}

function M.setup()
    -- Don't setup this plugin in vscode
    if not vim.g.vscode then
        require("lualine").setup({})
    end
end

return M
