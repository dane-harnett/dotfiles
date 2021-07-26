local saga = require 'lspsaga'
local utils = require'daneharnett.utils'

saga.init_lsp_saga()

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

