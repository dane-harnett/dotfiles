local M = {}

function M.init()
    require("lazydev").setup({
        library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
    })
end

function M.autocmd()
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "lua",
        once = true,
        callback = function()
            M.init()
        end,
    })
end

return M
