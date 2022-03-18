local treesitter_configs = require'nvim-treesitter.configs'
treesitter_configs.setup {
  ensure_installed = {
    "bash",
    "css",
    "html",
    "java",
    "javascript",
    "json",
    "lua",
    "tsx",
    "typescript",
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true
  },
  playground = {
    enable = true,
    updatetime = 25
  }
}

local group = vim.api.nvim_create_augroup("FoldsWithTreesitter", { clear = true })
local parsers = require('nvim-treesitter.parsers').available_parsers()
local additional_file_types = {
  "typescriptreact",
}
local all_file_types = {}

for _, filetype in ipairs(parsers) do
  table.insert(all_file_types, filetype)
end
for _, filetype in ipairs(additional_file_types) do
  table.insert(all_file_types, filetype)
end

for _, filetype in ipairs(all_file_types) do
  vim.api.nvim_create_autocmd("FileType", {
    pattern = filetype,
    command = 'setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr()',
    group = group
  })
end

