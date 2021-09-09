require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tabnine = false;
    tags = true;
    snippets_nvim = true;
    treesitter = true;
  };
}

vim.cmd[[inoremap <silent><expr> <C-Space> compe#complete()]]
vim.cmd[[inoremap <silent><expr> <C-y>     compe#confirm('<CR>')]]
vim.cmd[[inoremap <silent><expr> <C-e>     compe#close('<C-e>')]]
vim.cmd[[inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })]]
vim.cmd[[inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })]]

-- completion keys
vim.cmd[[inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"]]
vim.cmd[[inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"]]
vim.cmd[[inoremap <expr> <CR>    pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"]]
