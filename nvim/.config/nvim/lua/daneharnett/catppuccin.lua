local M = {}

function M.init()
    local catppuccin_status_ok, catppuccin = pcall(require, "mason")
    if not catppuccin_status_ok then
        return
    end

    vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
    catppuccin.setup()
    vim.cmd("colorscheme catppuccin")
end

return M
