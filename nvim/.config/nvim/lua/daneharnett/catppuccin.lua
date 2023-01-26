local M = {}

function M.init()
    vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
    require("catppuccin").setup()
    vim.cmd("colorscheme catppuccin")
end

return M
