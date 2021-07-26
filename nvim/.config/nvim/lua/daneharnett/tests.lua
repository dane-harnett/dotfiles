local utils = require'daneharnett.utils'
local load_mappings = function()
  utils.key_mapper('n', '<leader>tf', ':TestFile<CR>')
end
load_mappings();
