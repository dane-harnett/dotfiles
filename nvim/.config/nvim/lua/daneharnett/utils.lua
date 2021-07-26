local M = {}

M.key_mapper = function(mode, key, result)
  vim.api.nvim_set_keymap(
    mode,
    key,
    result,
    {noremap = true, silent = true}
  )
end
M.current_buffer_key_mapper = function(mode, key, result)
  vim.api.nvim_buf_set_keymap(
    0,
    mode,
    key,
    result,
    {noremap = true, silent = true}
  )
end

return M
