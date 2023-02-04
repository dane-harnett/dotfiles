local M = {}

M.keymap = function(mode, key, result)
    vim.keymap.set(mode, key, result, { noremap = true, silent = true })
end
M.current_buffer_keymap = function(mode, key, result)
    vim.keymap.set(mode, key, result, { buffer = true, noremap = true, silent = true })
end
M.buffer_keymap = function(bufnr, mode, key, result)
    vim.keymap.set(mode, key, result, { buffer = bufnr, noremap = true, silent = true })
end
-- deprecated
M.key_mapper = function(mode, key, result)
    vim.keymap.set(mode, key, result, { noremap = true, silent = true })
end

M.create_format_on_save_autocmd = function(augroup_name, bufnr, timeout_ms)
    timeout_ms = timeout_ms or 1000

    local group = vim.api.nvim_create_augroup(augroup_name .. "FormatOnSave", { clear = false })
    vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
            vim.lsp.buf.format({ timeout_ms = timeout_ms })
        end,
        group = group,
    })
end

return M
