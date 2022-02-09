local lspsaga = require 'lspsaga'
local utils = require'daneharnett.utils'

lspsaga.setup { -- defaults ...
  debug = false,
  use_saga_diagnostic_sign = true,
  -- diagnostic sign
  error_sign = "E",
  warn_sign = "W",
  hint_sign = "H",
  infor_sign = "I",
  diagnostic_header_icon = " D  ",
  -- code action title icon
  code_action_icon = "A ",
  code_action_prompt = {
    enable = true,
    sign = true,
    sign_priority = 40,
    virtual_text = true,
  },
  finder_definition_icon = "  ",
  finder_reference_icon = "  ",
  max_preview_lines = 10,
  finder_action_keys = {
    open = "o",
    vsplit = "s",
    split = "i",
    quit = "q",
    scroll_down = "<C-f>",
    scroll_up = "<C-b>",
  },
  code_action_keys = {
    quit = "q",
    exec = "<CR>",
  },
  rename_action_keys = {
    quit = "<C-c>",
    exec = "<CR>",
  },
  definition_preview_icon = "  ",
  border_style = "single",
  rename_prompt_prefix = "➤",
  server_filetype_map = {},
  diagnostic_prefix_format = "%d. ",
}

-- lsp provider to find the cursor word definition and reference
utils.key_mapper('n', 'gh', ':lua require"lspsaga.provider".lsp_finder()<CR>')

-- code action
utils.key_mapper('n', '<leader>ca', ':lua require"lspsaga.codeaction".code_action()<CR>')
utils.key_mapper('v', '<leader>ca', ':<C-U>lua require("lspsaga.codeaction").range_code_action()<CR>')

-- show hover doc
utils.key_mapper('n', 'K', ':lua require"lspsaga.hover".render_hover_doc()<CR>')

-- scroll down hover doc or scroll in definition preview
utils.key_mapper('n', '<C-f>', ':lua require"lspsaga.action".smart_scroll_with_saga(1)<CR>')

-- scroll up hover doc
utils.key_mapper('n', '<C-b>', ':lua require"lspsaga.action".smart_scroll_with_saga(-1)<CR>')

-- show signature help
utils.key_mapper('n', 'gs', ':lua require"lspsaga.signaturehelp".signature_help()<CR>')

-- rename
utils.key_mapper('n', 'gr', ':lua require"lspsaga.rename".rename()<CR>')

-- preview definition
utils.key_mapper('n', 'gd', ':lua require"lspsaga.provider".preview_definition()<CR>')

-- show diagnostic
utils.key_mapper('n', '<leader>cd', ':lua require"lspsaga.diagnostic".show_line_diagnostics()<CR>')

-- jump to diagnostic
utils.key_mapper('n', '[e', ':lua require"lspsaga.diagnostic".lsp_jump_diagnostic_prev()<CR>')
utils.key_mapper('n', ']e', ':lua require"lspsaga.diagnostic".lsp_jump_diagnostic_next()<CR>')

-- float terminal also you can pass the cli command in open_float_terminal function
-- @wtf: some reason ALT-d doesn't work on my mac???
utils.key_mapper('n', '<A-d>', ':lua require"lspsaga.floaterm".open_float_terminal()<CR>')
utils.key_mapper('t', '<A-d>', '<C-\\><C-n>:lua require"lspsaga.floaterm".close_float_terminal()<CR>')

