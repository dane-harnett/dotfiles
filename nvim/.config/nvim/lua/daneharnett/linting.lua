local M = {}

function M.init()
    local utils = require("daneharnett.utils")
    local lint_status_ok, lint = pcall(require, "lint")
    if not lint_status_ok then
        return
    end

    lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        svelte = { "eslint_d" },
        python = { "pylint" },
    }

    local mason_nvim_lint_status_ok, mason_nvim_lint = pcall(require, "mason-nvim-lint")
    if mason_nvim_lint_status_ok then
        mason_nvim_lint.setup()
    end

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function(args)
            local filetype = vim.api.nvim_get_option_value("filetype", { buf = args.buf })

            if vim.tbl_contains(js_filetypes, filetype) then
                if not utils.has_eslint_config(args.buf) then
                    return
                end
            end

            lint.try_lint()
        end,
    })

    vim.keymap.set("n", "<leader>l", function()
        lint.try_lint()
    end, { desc = "Trigger linting for current file" })
end

return M
