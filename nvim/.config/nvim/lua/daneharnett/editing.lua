local utils = require'daneharnett.utils'
local load_mappings = function()
  -- Move text up and down
  utils.keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi")
  utils.keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi")

  -- Visual --
  -- Stay in indent mode
  utils.keymap("v", "<", "<gv")
  utils.keymap("v", ">", ">gv")

  -- Move text up and down
  utils.keymap("v", "<A-j>", ":m .+1<CR>==")
  utils.keymap("v", "<A-k>", ":m .-2<CR>==")
  utils.keymap("v", "p", '"_dP')

  -- Visual Block --
  -- Move text up and down
  utils.keymap("x", "J", ":move '>+1<CR>gv-gv")
  utils.keymap("x", "K", ":move '<-2<CR>gv-gv")
  utils.keymap("x", "<A-j>", ":move '>+1<CR>gv-gv")
  utils.keymap("x", "<A-k>", ":move '<-2<CR>gv-gv")
end
load_mappings();
