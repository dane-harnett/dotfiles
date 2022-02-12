local utils = require'daneharnett.utils'

local load_mappings = function()
  -- When in visual mode, after yanking keep the cursor in the last selected
  -- position.
  utils.keymap('v', 'y', 'ygv<Esc>')
end
load_mappings();
