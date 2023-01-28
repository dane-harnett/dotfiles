local M = {}

function M.init()
    -- Exclude this from vscode
    if vim.g.vscode then
        return
    end

    -- configure diagnostics
    -- don't try to put this in the lsp on_attach because it causes both folds and
    -- blamer virtual text to break.
    vim.g.diagnostic_enable_virtual_text = 1
    vim.g.diagnostic_insert_delay = 1
end

return M
