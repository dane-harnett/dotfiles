set exrc " Wont open project .nvimrc without this here

call plug#begin("~/.vim/plugged")
  " Plugin Section

  " Theme
  " Plug 'gruvbox-community/gruvbox'
  Plug 'ayu-theme/ayu-vim'

  " Language Client
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver']

  " lsp and lua
"  Plug 'neovim/nvim-lspconfig'
"  Plug 'nvim-lua/completion-nvim'
"  Plug 'nvim-lua/lsp-status.nvim'
"  Plug 'nvim-lua/diagnostic-nvim'

  Plug 'RishabhRD/popfix'
  Plug 'RishabhRD/nvim-lsputils'

  " TypeScript Highlighting
  Plug 'leafgarland/typescript-vim'
  Plug 'pangloss/vim-javascript'
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'jparise/vim-graphql'
  Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

  " File Search
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'airblade/vim-rooter'

  Plug 'preservim/nerdtree'

  Plug 'editorconfig/editorconfig-vim'

  " telescope requirements...
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
call plug#end()


"lua require 'daneharnett'

" requires silversearcher-ag
" used to ignore gitignore files
let $FZF_DEFAULT_COMMAND = 'rg --files'
" let g:ctrlp_custom_ignore = '(.*)\node_modules\|DS_Store\|git'

" nnoremap <C-p> :FZF<CR>

" LSP
"set omnifunc=v:lua.vim.lsp.omnifunc
"set completeopt=menuone,noinsert,noselect
"let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
"let g:diagnostic_enable_virtual_text = 1
"let g:diagnostic_insert_delay = 1
"let g:qf_auto_open_quickfix = 1
"let g:qf_auto_open_loclist = 1
"function! LspStatus() abort
"  if luaeval('#vim.lsp.buf_get_clients() > 0')
"    return luaeval("require('lsp-status').status()")
"  endif
"  return ''
"endfunction
"set statusline+=\ %{LspStatus()}

"nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<cr>
"nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<cr>
"nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<cr>
"nnoremap <silent> J     <cmd>lua vim.lsp.util.show_line_diagnostics()<cr>
"nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<cr>
"nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<cr>
"nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<cr>
"nnoremap <silent> gn    <cmd>lua vim.lsp.buf.rename()<cr>
"nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<cr>
"nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<cr>
"nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<cr>
"vnoremap <silent> ga    <cmd>'<,'>lua vim.lsp.buf.range_code_action()<cr>

" Leader key
let mapleader = " "

"Remap keys for applying codeAction to the current line.
"nmap <a-cr>  <Plug>(coc-codeaction)
"Apply AutoFix to problem on the current line.
"nmap <leader>qf  <Plug>(coc-fix-current)

" Format on save
" autocmd BufWritePre *js,*ts,*jsx,*tsx,*.graphql,*.json,*.md,*.mdx :Prettier
