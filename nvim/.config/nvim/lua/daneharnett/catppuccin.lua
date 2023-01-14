local M = {}

function M.init()
    -- Don't apply this colorscheme in vscode
    if not vim.g.vscode then
        vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
        require("catppuccin").setup()
        vim.cmd("colorscheme catppuccin")
    end
end

return M
