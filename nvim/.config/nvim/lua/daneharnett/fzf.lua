local M = {}

function M.init()
    require("fzf-lua").setup({})

    vim.keymap.set({ "n", "v", "i" }, "<C-x><C-f>", function()
        require("fzf-lua").complete_path()
    end, { silent = true, desc = "Fuzzy complete path" })

    vim.keymap.set({ "n", "v", "i" }, "<C-x><C-x>", function()
        require("fzf-lua").complete_path({
            cmd = "fd --type=d --hidden --exclude=.git --exclude=node_modules",
        })
    end, { silent = true, desc = "Fuzzy complete directory path" })
end

return M
