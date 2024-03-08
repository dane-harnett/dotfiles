local M = {}

function M.init()
    local conform_status_ok, conform = pcall(require, "conform")
    if not conform_status_ok then
        return
    end
    local conform_util_status_ok, conform_util = pcall(require, "conform.util")
    if not conform_util_status_ok then
        return
    end
    local conform_eslint_d_status_ok, conform_eslint_d = pcall(require, "conform.formatters.eslint_d")
    if not conform_eslint_d_status_ok then
        return
    end
    local conform_prettierd_status_ok, conform_prettierd = pcall(require, "conform.formatters.prettierd")
    if not conform_prettierd_status_ok then
        return
    end

    conform_eslint_d.cwd = conform_util.root_file({
        "yarn.lock",
        "package-lock.json",
    })
    conform_prettierd.cwd = conform_util.root_file({
        "yarn.lock",
        "package-lock.json",
    })

    conform.setup({
        formatters_by_ft = {
            javascript = { "prettierd", "eslint_d" },
            typescript = { "prettierd", "eslint_d" },
            javascriptreact = { "prettierd", "eslint_d" },
            typescriptreact = { "prettierd", "eslint_d" },
            svelte = { "prettierd" },
            css = { "prettierd" },
            html = { "prettierd" },
            json = { "prettierd" },
            yaml = { "prettierd" },
            markdown = { "prettierd" },
            graphql = { "prettierd" },
            lua = { "stylua" },
            python = { "isort", "black" },
        },
        format_on_save = {
            lsp_fallback = true,
            async = false,
            timeout_ms = 10000,
        },
    })

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
        conform.format({
            lsp_fallback = true,
            async = false,
            timeout_ms = 10000,
        })
    end, { desc = "Format file or range (in visual mode)" })
end

return M
