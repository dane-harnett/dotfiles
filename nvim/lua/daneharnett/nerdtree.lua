local utils = require'daneharnett.utils'
local load_mappings = function()
  utils.key_mapper('n', '<leader>ne', ':NERDTreeToggle<CR>')
end
load_mappings();

vim.g.NERDTreeIgnore = {'^.git$', '^node_modules$'}
vim.g.NERDTreeShowHidden=1
vim.g.NERDTreeWinPos="right"
