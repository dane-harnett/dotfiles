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

return M
