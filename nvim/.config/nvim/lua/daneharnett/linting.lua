local M = {}

function M.init()
    local lint_status_ok, lint = pcall(require, "lint")
    if not lint_status_ok then
        return
    end

    lint.linters_by_ft = {
        javascript = { "eslint" },
        typescript = { "eslint" },
        javascriptreact = { "eslint" },
        typescriptreact = { "eslint" },
        svelte = { "eslint" },
        python = { "pylint" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
            lint.try_lint()
        end,
    })

    vim.keymap.set("n", "<leader>l", function()
        lint.try_lint()
    end, { desc = "Trigger linting for current file" })
end

return M
