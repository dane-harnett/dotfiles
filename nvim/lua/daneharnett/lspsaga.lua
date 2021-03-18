local saga = require 'lspsaga'
saga.init_lsp_saga()

-- lsp provider to find the cursor word definition and reference
vim.cmd[[nnoremap <silent> gh <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>]]

-- code action
vim.cmd[[nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>]]
vim.cmd[[vnoremap <silent><leader>ca <cmd>'<,'>lua require('lspsaga.codeaction').range_code_action()<CR>]]

-- show hover doc
vim.cmd[[nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>]]
-- scroll down hover doc or scroll in definition preview
vim.cmd[[nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>]]
-- scroll up hover doc
vim.cmd[[nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>]]

-- show signature help
vim.cmd[[nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>]]

-- rename
vim.cmd[[nnoremap <silent> gr <cmd>lua require('lspsaga.rename').rename()<CR>]]

-- preview definition
vim.cmd[[nnoremap <silent> gd <cmd>lua require'lspsaga.provider'.preview_definition()<CR>]]

-- show diagnostic
vim.cmd[[nnoremap <silent><leader>cd <cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>]]
-- jump to diagnostic
vim.cmd[[nnoremap <silent> [e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>]]
vim.cmd[[nnoremap <silent> ]e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>]]

-- float terminal also you can pass the cli command in open_float_terminal function
vim.cmd[[nnoremap <silent> <A-d> <cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR>]]
vim.cmd[[tnoremap <silent> <A-d> <C-\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>]]

