local utils = require'daneharnett.utils'

local load_mappings = function()
  -- When in visual mode, after yanking keep the cursor in the last selected
  -- position.
  utils.key_mapper('v', 'y', 'ygv<Esc>')
end
load_mappings();
